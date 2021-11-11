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

// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code

def create_enemy(pos: float2)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let vel = float2(0.0, 0.0)
        cmp |> apply_decs_template([[Pos p = pos]])
        cmp |> apply_decs_template([[Vel v = vel]])
        cmp |> apply_decs_template([[Enemy]])
        cmp |> apply_decs_template([[Unit color = make_color(1.0, 0.0, 0.0, 1.0), size = 15.0]])
        cmp |> apply_decs_template([[Shootable cooldown = PLAYER_WEAPON_COOLDOWN, cd_time = 0.0]])

// 'initialize' runs once when game starts and every hot-reload
[export]
def initialize()
    restart()
    set_window_title("TopDown")
    prepare_background()
    create_player()
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
