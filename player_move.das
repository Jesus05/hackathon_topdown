require daslib/media
require daslib/decs_boost
require ecs_templates

[decs(stage = update)]
def user_move(var v: Vel; p: Player; u: Unit)
    var dir = float2(0.0, 0.0)
    if (get_key(VK_A))
        dir.x = -1.0
    elif(get_key(VK_D))
        dir.x = +1.0

    if (get_key(VK_W))
        dir.y = -1.0
    elif get_key(VK_S)
        dir.y = +1.0
    
    v.v = normalize(dir) * u.speed
