require daslib/media
require daslib/decs_boost
require ecs_templates

require background
require camera
require player
require player_move
require player_shoot
require velocity
require drawable
require shootable_cooldown
require bullet
require explosion
require life
require dead
require enemy

// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code

var seed : int4

def create_enemy_spawner()
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let pos = float2(0.0, 0.0)
        cmp |> apply_decs_template([[Spawner pos = pos, current = 0u, max = 2000u, spawn_every = 0.1, last_spawn = get_time_after_start()]])
        cmp |> apply_decs_template([[Enemy]])

[decs(stage = update)]
def enemy_spawner_counter(var s: Spawner; e: Enemy)
    var count = 0u;
    query() <| $(e: Enemy; u: Unit)
        count++
    s.current = count

[decs(stage = update)]
def enemy_spawner(var s: Spawner; e: Enemy)
    if s.current >= s.max
        return
    let time = get_time_after_start() - s.last_spawn
    if time >= s.spawn_every        
        var random = random_unit_vector(seed)
        while(random.x == 0.0 && random.y == 0.0)
            random = random_unit_vector(seed)
            debug("Created full Z vector")
        let max_screen = length(float2(float(get_screen_width()/2), float(get_screen_height()/2)))
        var pos = normalize(float2(random.x, random.y)) * max_screen * (2.1 + (random.z / 3.0))
        query() <| $(c: Camera; p: Pos)
            pos += p.p
        create_enemy(pos)
        s.last_spawn = get_time_after_start()
    pass

// 'initialize' runs once when game starts and every hot-reload
[export]
def initialize()
    restart()
    seed = random_seed(2349874);
    set_window_title("TopDown")
    prepare_background()
    create_player()
    create_enemy_spawner()
    create_enemy(float2(500.0, 200.0))
    commit()

// this function is called to update game data,
// dt - time elapsed since the previous update (in seconds)
[export]
def act(dt: float)
    if get_key(VK_ESCAPE)
        schedule_quit_game()
    decs_stage("update")

// this function will be called every frame after 'act',
// you can draw anything in this function
[export]
def draw
    enable_alpha_blend()
    decs_stage("draw_layer0")
    decs_stage("draw")
//    decs_stage("draw_debug")
