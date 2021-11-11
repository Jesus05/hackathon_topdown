require daslib/media
require daslib/decs_boost
require ecs_templates
require camera

[decs_template]
struct Player
    empty: bool

[export]
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