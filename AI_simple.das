require daslib/media
require daslib/decs_boost
require ecs_templates

require event
require bullet

[decs(stage = event)]
def AI_setter(a: Event_AI_need; eid: EntityId)
    update_entity(eid) <| @( eid, cmp )
        cmp |> remove_decs_template`Event_AI_need()
        cmp |> apply_decs_template([[AI_simple_move]])
        cmp |> apply_decs_template([[AI_simple_shoot]])


[decs(stage = update)]
def AI_simple_move(p: Pos; var v: Vel; a: AI_simple_move; u: Unit)
    var to = float2(0.0, 0.0)
    query() <| $(p: Player; pl_u: Unit; pl_pos: Pos)
        to = pl_pos.p
    let dir = (to - p.p) / 0.1
    let dir_sq = length_sq(dir)
    let vel = normalize(dir) * u.speed
    let vel_sq = length_sq(vel)
    if vel_sq < dir_sq
        v.v = vel
    else
        v.v = dir


[decs(stage = update)]
def AI_simple_shoot(p: Pos; v: Vel; a: AI_simple_shoot; var s: Shootable; var eid: EntityId)
    if s.cd_time > 0.0
        return
    var to = float2(0.0, 0.0)
    query() <| $(p: Player; u: Unit; pl_pos: Pos)
        to = pl_pos.p
    create_bullet(p.p, to, v.v,  eid, s.damage)
    s.cd_time = s.cooldown
