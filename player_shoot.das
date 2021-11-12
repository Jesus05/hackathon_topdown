require daslib/media
require daslib/decs_boost
require ecs_templates

require bullet

[decs(stage = update)]
def user_shoot(var s: Shootable; pos: Pos; vel: Vel; pl: Player; var eid: EntityId)
    if s.cd_time > 0.0
        return
    if get_mouse_button(MB_LEFT)
        let mouse_screen_pos = get_mouse_position()
        let mouse_world_pos = screen_to_world(mouse_screen_pos)
        create_bullet(pos.p, mouse_world_pos, vel.v,  eid, s.damage_mod)
        s.cd_time = s.cooldown

/*
[decs(stage = update)]
def user_shoot_enemy(var s: Shootable; pos: Pos; vel: Vel; pl: Player; var eid: EntityId)
    if s.cd_time > 0.0
        return
    var to = float2(0.0, 0.0)
    query() <| $(p: Pos; e:Enemy)
        to = p.p
    create_bullet(pos.p, to, vel.v,  eid, s.damage)
    s.cd_time = s.cooldown
*/