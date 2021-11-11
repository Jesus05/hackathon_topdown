require daslib/media
require daslib/decs_boost
require ecs_templates

require background
require player
require velocity
require drawable
// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code

[decs_template]
struct Shoot
    life: float
    from: float2
    to: float2

def create_shoot(from: float2; to: float2)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let life = 1.0
        cmp |> apply_decs_template([[Shoot life = life, from = from, to = to]])
    return

// 'initialize' runs once when game starts and every hot-reload
[export]
def initialize()
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
    return

[decs(stage = update)]
def shoot_remover(var s: Shoot; eid: EntityId)
    if s.life <= 0.0
        delete_entity(eid)
    s.life -= get_delta_time()

[decs(stage = update)]
def shootable_cooldown(var s: Shootable)
    s.cooldown -= get_delta_time()

[decs(stage = update)]
def user_shoot(var s: Shootable; pos: Pos; pl: Player)
    if s.cooldown > 0.0
        return
    if get_mouse_button(MB_LEFT)
        let mouse_screen_pos = get_mouse_position()
        let mouse_world_pos = screen_to_world(mouse_screen_pos)
        create_shoot(pos.p, mouse_world_pos)
        s.cooldown = 0.3
        debug("user_shoot_mouse_down")

[decs(stage = draw)]
def shoot_draw(var s: Shoot)
    line(s.from.x, s.from.y, s.to.x, s.to.y, make_color(1.0, 0.0, 1.0, 1.0))

// this function will be called every frame after 'act',
// you can draw anything in this function
[export]
def draw
    enable_alpha_blend()
    decs_stage("draw_layer0")
    decs_stage("draw")
    return
