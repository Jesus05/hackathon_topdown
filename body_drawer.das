require daslib/media
require daslib/decs_boost
require ecs_templates

let turret_size = 40.0
let turret_len = (turret_size - turret_size / 1.5) * 2.0
let turret_raduis = turret_size / 1.5 + turret_len
let turret_width = turret_size / 1.5
let body_radius = turret_size / 1.5

let shotgun_points : array<float2> <- [{float2 
        float2(-turret_width * 2.5 / 7.0, turret_raduis);
        float2(turret_width * 2.5 / 7.0, turret_raduis);
        float2(-turret_width * 1.5 / 7.0, body_radius);
        float2(turret_width * 1.5 / 7.0, body_radius)}]
let shotgun_indices : array<int> <- [{int (0); (1); (2); (3)}]

var shotgun_mesh <- create_mesh_triangle_strip(shotgun_points, shotgun_indices)
var solid_texture <- create_image(1, 1)

def draw_shotgun(pos: float2; size: float; color: uint; angle: float)
    solid_texture |> set_pixel(0, 0, multiply_colors(color, make_color(0.8, 0.8, 0.8, 1.0)))
    shotgun_mesh |> draw_mesh(solid_texture, pos.x, pos.y, angle, size / 40.0)

    fill_circle(pos.x, pos.y, size / 1.5, multiply_colors(color, make_color(0.8, 0.8, 0.8, 1.0)))
    circle(pos.x, pos.y, size / 1.5, make_color(0.1, 0.1, 0.1, 1.0))
    return

def draw_laser(pos: float2; size: float; color: uint; angle: float)
    draw_shotgun(pos, size, color, angle)
    return

def draw_rocket(pos: float2; size: float; color: uint; angle: float)
    draw_shotgun(pos, size, color, angle)
    return

def draw_sniper(pos: float2; size: float; color: uint; angle: float)
    draw_shotgun(pos, size, color, angle)
    return

def draw_assault(pos: float2; size: float; color: uint; angle: float)
    draw_shotgun(pos, size, color, angle)
    return