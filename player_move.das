require daslib/media
require daslib/decs_boost
require ecs_templates

[decs(stage = update)]
def user_move(var v: Vel; p: Player)
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