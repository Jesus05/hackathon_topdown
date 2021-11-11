require daslib/media
require daslib/decs_boost
require background
// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code

[decs_template]
struct Pos
    p: float2

[decs_template]
struct Vel
    v: float2

[decs_template]
struct Player
    empty: bool

[decs_template]
struct Camera
    empty: bool

[decs_template]
struct Drawable
    empty: bool

def create_player()
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let pos = float2(0.0, 0.0)
        let vel = float2(0.0, 0.0)
        cmp |> apply_decs_template([[Pos p = pos]])
        cmp |> apply_decs_template([[Vel v = vel]])
        cmp |> apply_decs_template([[Player]])
        cmp |> apply_decs_template([[Camera]])
        cmp |> apply_decs_template([[Drawable]])

// 'initialize' runs once when game starts and every hot-reload
[export]
def initialize(is_hard_reload: bool)
    restart()
    set_window_title("TopDown")
//    if is_hard_reload
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
    return

[decs(stage = update)]
def set_camera(p: Pos; c: Camera)
    setup_2d_camera(p.p, 1.0)

[decs(stage = update)]
def move_velocity(var p: Pos; v: Vel)
    let dt = get_delta_time()
    p.p += v.v * dt

[decs(stage = update)]
def user_control(var v: Vel; p: Player)
    if (get_key(VK_A))
        v.v.x = -300.0
    elif(get_key(VK_D))
        v.v.x = +300.0
    else
        v.v.x = 0.0

    if (get_key(VK_W))
        v.v.y = -300.0
    elif get_key(VK_S)
        v.v.y = +300.0
    else
        v.v.y = 0.0

[decs(stage = draw1)]
def draw_drawable(p: Pos; d: Drawable)
    fill_circle(p.p.x, p.p.y, 20.0, 0xFFFFFF)



// this function will be called every frame after 'act',
// you can draw anything in this function
[export]
def draw
    decs_stage("draw")
    decs_stage("draw1")
    return
