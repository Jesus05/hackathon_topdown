require daslib/media
require daslib/decs_boost
require ecs_templates
require globals
require AI_simple

require enemy
require dead

let SPAWN_SCREEN_K = 1.1

def create_enemy_spawner()
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        cmp |> apply_decs_template([[EnemySpawner current = 0u, max = 10u, spawn_every = 1.0, last_spawn = get_time_after_start()]])

[decs(stage = update)]
def enemy_spawner_counter(var s: EnemySpawner)
    var count = 0u;
    query() <| $(e: Enemy; u: Unit)
        count++
    s.current = count

[decs(stage = update)]
def enemy_spawner(var s: EnemySpawner)
    if s.current >= s.max
        return
    let time = get_time_after_start() - s.last_spawn
    if time >= s.spawn_every
        var random = random_unit_vector(g_seed)
        while(random.x == 0.0 && random.y == 0.0)
            random = random_unit_vector(g_seed)
            debug("Created full Z vector")
        let max_screen = length(float2(float(get_screen_width()/2), float(get_screen_height()/2)))
        var pos = normalize(float2(random.x, random.y)) * max_screen * (SPAWN_SCREEN_K + 1.0 + (random.z / 3.0))
        query() <| $(c: Camera; p: Pos)
            pos += p.p
        create_enemy(pos)
        s.last_spawn = get_time_after_start() + random_float(g_seed) * s.spawn_every

[decs(stage = update)]
def enemy_despawner(var s: EnemySpawner)
    if s.current == 0u
        return
    let time = get_time_after_start() - s.last_spawn
    if time >= s.spawn_every
        let max_screen = length(float2(float(get_screen_width()/2), float(get_screen_height()/2))) * SPAWN_SCREEN_K
        let max_screen_sq = max_screen * max_screen
        var cam_pos = float2(0.0, 0.0)
        query() <| $(c: Camera; p: Pos)
            cam_pos = p.p
        find_query() <| $(e: Enemy; u: Unit; p: Pos; var eid: EntityId)
            if (length_sq(cam_pos - p.p) < max_screen_sq)
                return false
            delete_unit(u.chassis, eid)
            s.last_spawn = get_time_after_start() + random_float(g_seed) * s.spawn_every
            return true