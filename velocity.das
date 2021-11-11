require daslib/media
require daslib/decs_boost
require ecs_templates

[decs(stage = update3)]
def move_velocity(var p: Pos; v: Vel)
    let dt = get_delta_time()
    p.p += v.v * dt