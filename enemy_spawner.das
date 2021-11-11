require daslib/media
require daslib/decs_boost
require ecs_templates
require globals
require AI_simple

require enemy

def create_enemy_spawner()
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let pos = float2(0.0, 0.0)
        cmp |> apply_decs_template([[EnemySpawner current = 0u, max = 10u, spawn_every = 0.1, last_spawn = get_time_after_start()]])

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
        var pos = normalize(float2(random.x, random.y)) * max_screen * (2.1 + (random.z / 3.0))
        query() <| $(c: Camera; p: Pos)
            pos += p.p
        create_enemy(pos)
        s.last_spawn = get_time_after_start()