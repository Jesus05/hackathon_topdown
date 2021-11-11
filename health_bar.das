require daslib/media
require daslib/decs_boost
require ecs_templates

[decs(stage = draw)]
def health_bar_draw(p: Pos; u: Unit)
    let bar_height = 5.0
    let left_up = p.p - float2(u.size, u.size + bar_height * 2.0)
    let len = u.size * 2.0
    fill_rect(left_up.x, left_up.y, len, bar_height, make_color(1.0, 1.0, 0.0, 1.0))
    fill_rect(left_up.x, left_up.y, len * u.health / u.health_max, bar_height, make_color(1.0, 0.0, 0.0, 1.0))