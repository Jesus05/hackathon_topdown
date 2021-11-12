require daslib/media
require daslib/decs_boost
require ecs_templates

require chassis_drawer
require body_drawer

[decs(stage = draw)]
def draw_unit(p: Pos; d: Unit; v: Vel; s: Shootable)
    let have = query(d.chassis) <| $(c: Chassis)
        if c.type_ == ChassisType pillar
            draw_pillar(p.p, d.size, d.color)
        elif c.type_ == ChassisType hover
            draw_hover(p.p, d.size, d.color)
        elif c.type_ == ChassisType wheel
            draw_wheel(p.p, d.size, d.color, v.v)
        elif c.type_ == ChassisType track
            draw_track(p.p, d.size, d.color, v.v)
        else 
            debug("Unknown chassis enum value {c.type_}")
    if !have
        circle(p.p.x, p.p.y, d.size, d.color)
    
    draw_shotgun(p.p, d.size, d.color, s.angle)
    



