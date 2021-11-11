require daslib/media
require daslib/decs_boost
require ecs_templates

require background
require player
require velocity
require drawable
// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code

// 'initialize' runs once when game starts and every hot-reload
[export]
def initialize(is_hard_reload: bool)
    restart()
    set_window_title("TopDown")
    prepare_background()
    create_player()
    return

// this function is called to update game data,
// dt - time elapsed since the previous update (in seconds)
[export]
def act(dt: float)
    if get_key(VK_ESCAPE)
        schedule_quit_game()
    decs_stage("update")
    decs_stage("update1")
    decs_stage("update2")
    decs_stage("update3")
    return

// this function will be called every frame after 'act',
// you can draw anything in this function
[export]
def draw
    decs_stage("draw")
    decs_stage("draw1")
    decs_stage("draw2")
    return
