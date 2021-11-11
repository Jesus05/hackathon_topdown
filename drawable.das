require daslib/media
require daslib/decs_boost
require ecs_templates

[decs(stage = draw)]
def draw_drawable(p: Pos; d: Unit)
    fill_circle(p.p.x, p.p.y, d.size, d.color)

[decs(stage = draw)]
def draw_enemy_arrow(enemy_pos: Pos; d: Unit; e: Enemy)
    var camera_position = float2(0.0, 0.0)
    query() <| $(camera_pos: Pos; c: Camera)
        camera_position = camera_pos.p
    let x_dif = enemy_pos.p.x - camera_position.x
    let y_dif = enemy_pos.p.y - camera_position.y
    if (x_dif >= float(-get_screen_width() / 2) && x_dif <= float(get_screen_width() / 2) &&
       y_dif >= float(-get_screen_height() / 2) && y_dif <= float(get_screen_height() / 2))
        return
    let dir = normalize(enemy_pos.p - camera_position)
    let arrow_pos = camera_position + dir * 300.0
    fill_circle(arrow_pos.x, arrow_pos.y, d.size * 0.3, multiply_colors(d.color, make_color(0.3, 0.3, 0.3, 1.0)))

