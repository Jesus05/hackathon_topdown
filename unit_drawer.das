require daslib/media
require daslib/decs_boost
require ecs_templates

require chassis_drawer
require body_drawer

[decs(stage = draw)]
def draw_unit(p: Pos; d: Unit; v: Vel; s: Shootable)
    var have = query(d.chassis) <| $(c: Chassis)
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
    
    have = query(d.body) <| $(b: Body)
        if b.type_ == BodyType shotgun
            draw_shotgun(p.p, d.size, d.color, s.angle)
        elif b.type_ == BodyType laser
            draw_laser(p.p, d.size, d.color, s.angle)
        elif b.type_ == BodyType rocket
            draw_rocket(p.p, d.size, d.color, s.angle)
        elif b.type_ == BodyType sniper
            draw_sniper(p.p, d.size, d.color, s.angle)
        elif b.type_ == BodyType assault
            draw_assault(p.p, d.size, d.color, s.angle)
        else
            debug("Unknown body enum value {b.type_}")

    if !have
        let offset = float2(sin(-s.angle), cos(-s.angle)) * d.size
        circle(p.p.x + offset.x, p.p.y + offset.y, d.size / 3.0, d.color)
    
[decs(stage = draw)]
def draw_pillar_help(u: Unit; p: Player)
    query(u.chassis) <| $(c: Chassis)
        if (c.type_ == ChassisType pillar)
            let pos = screen_to_world(float2(20, 20))
            text_out(pos.x, pos.y, "Player chassis is pillar no move only shoot", make_color(1.0, 1.0, 1.0, 1.0))
    



