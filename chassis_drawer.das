require daslib/media
require daslib/decs_boost
require ecs_templates

var wheel: Image
var track: Image

def draw_pillar(pos: float2; size: float; color: uint)
    fill_circle(pos.x, pos.y, size, color)
    circle(pos.x, pos.y, size / 1.3, multiply_colors(color, make_color(0.8, 0.8, 0.8, 1.0)))
    circle(pos.x, pos.y, size / 1.5, make_color(0.1, 0.1, 0.1, 1.0))

def draw_hover(pos: float2; size: float; color: uint)
    let line_count = 2
    for x in range(-line_count, line_count + 1)
        for y in range(-line_count, line_count + 1)
            let x_ = float(x) / float(line_count)
            let y_ = float(y) / float(line_count)
            let dir = normalize(float2(x_, y_))
            let start = dir * size / 1.2 + pos
            let end = dir * size + pos
            line(start.x, start.y, end.x, end.y, make_color(1.0, 1.0, 1.0, 1.0))
    fill_circle(pos.x, pos.y, size / 1.5, color)
    circle(pos.x, pos.y, size / 1.5, make_color(0.1, 0.1, 0.1, 1.0))

def prepare_wheel()
    wheel <- create_image(40, 40)
    wheel |> make_image_color_transparent(wheel |> get_pixel(20, 20))
    for ix in range(10)
        for iy in range(15)
            wheel |> set_pixel(0 + ix, 0 + iy, make_color(1.0, 1.0, 1.0, 1.0))
            wheel |> set_pixel(30 + ix, 0 + iy, make_color(1.0, 1.0, 1.0, 1.0))
            wheel |> set_pixel(3 + ix, 25 + iy, make_color(1.0, 1.0, 1.0, 1.0))
            wheel |> set_pixel(27 + ix, 25 + iy, make_color(1.0, 1.0, 1.0, 1.0))

def draw_wheel(pos: float2; size: float; color: uint; vel: float2)
    if !wheel.valid
        prepare_wheel()
    wheel |> draw_image_transformed(pos.x, pos.y, float4(0.0, 0.0, 40.0, 40.0), color, float2(size*2.0, size*2.0), -atan2(vel.x, vel.y))

    fill_circle(pos.x, pos.y, size / 1.3, color)
    circle(pos.x, pos.y, size / 1.3, make_color(0.1, 0.1, 0.1, 1.0))

def prepare_track()
    track <- create_image(40, 40)
    track |> make_image_color_transparent(track |> get_pixel(20, 20))
    for ix in range(10)
        for iy in range(40)
            track |> set_pixel(0 + ix, 0 + iy, make_color(1.0, 1.0, 1.0, 1.0))
            track |> set_pixel(30 + ix, 0 + iy, make_color(1.0, 1.0, 1.0, 1.0))

def draw_track(pos: float2; size: float; color: uint; vel: float2)
    if !track.valid
        prepare_track()
    track |> draw_image_transformed(pos.x, pos.y, float4(0.0, 0.0, 40.0, 40.0), color, float2(size*2.0, size*2.0), -atan2(vel.x, vel.y))

    fill_circle(pos.x, pos.y, size / 1.15, color)
    circle(pos.x, pos.y, size / 1.15, make_color(0.1, 0.1, 0.1, 1.0))