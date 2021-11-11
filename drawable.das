require daslib/media
require daslib/decs_boost
require ecs_templates

[decs(stage = draw)]
def draw_drawable(p: Pos; d: Drawable)
    fill_circle(p.p.x, p.p.y, 20.0, 0xFFFFFF)