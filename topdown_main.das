require daslib/media
require daslib/decs_boost
require ecs_templates
require globals
require event

require background
require camera
require player
require player_move
require player_shoot
require velocity
require unit_drawer
require arrow_drawer
require shootable_cooldown
require bullet
require explosion
require life
require dead
require enemy
require enemy_spawner
require player_spawner
require health_bar
require AI_simple
require chassis
require body
require shoot

// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code

// 'initialize' runs once when game starts and every hot-reload
[export]
def initialize()
    restart()
    g_seed = random_seed(2349);
    set_window_title("TopDown")
    prepare_chassis()
    prepare_bodys()
    prepare_background()
    create_enemy_spawner()
    create_player_spawner(float2(0.0, 0.0))
//    create_enemy(float2(500.0, 200.0))
    commit()

// this function is called to update game data,
// dt - time elapsed since the previous update (in seconds)
[export]
def act(dt: float)
    if get_key(VK_ESCAPE)
        schedule_quit_game()
    decs_stage("update")
    decs_stage("event")

// this function will be called every frame after 'act',
// you can draw anything in this function
[export]
def draw
    enable_alpha_blend()
    decs_stage("draw_layer0")
    decs_stage("draw")
//    decs_stage("draw_debug")
