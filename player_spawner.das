require daslib/media
require daslib/decs_boost
require ecs_templates

require player

def create_player_spawner(pos: float2)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        cmp |> apply_decs_template([[PlayerSpawner pos = pos, current = 0u, max = 1u, spawn_every = 0.1, last_spawn = 0.0, lives = 1u]])

[decs(stage = update)]
def player_spawner_counter(var s: PlayerSpawner)
    var count = 0u;
    query() <| $(p: Player; u: Unit)
        count++
    s.current = count

[decs(stage = update)]
def player_spawner(var s: PlayerSpawner)
    if s.current >= s.max
        return
    let time = get_time_after_start() - s.last_spawn
    if time < s.spawn_every
        return
    if s.lives <= 0u
        debug("Game Over")
        s.lives++
        return
    create_player(s.pos)
    s.lives--
