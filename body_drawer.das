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

def draw_shotgun(pos: float2; size: float; color: uint; vel: float2)
    solid_texture |> set_pixel(0, 0, color)
    shotgun_mesh |> draw_mesh(solid_texture, pos.x, pos.y, 0.0, size / 40.0)

    fill_circle(pos.x, pos.y, size / 1.5, color)
    circle(pos.x, pos.y, size / 1.5, make_color(0.1, 0.1, 0.1, 1.0))
    return

def draw_laser()
    return

def draw_rocket()
    return

def draw_sniper()
    return

def draw_assault()
    return