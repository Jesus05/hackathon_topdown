require daslib/media
require daslib/decs_boost
require ecs_templates

[decs(stage = update)]
def set_camera(p: Pos; c: Camera)
    setup_2d_camera(p.p, 1.0)