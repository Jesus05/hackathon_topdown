require daslib/media
require daslib/decs_boost
require ecs_templates

[decs(stage = update)]
def AI_setter(a: AI_need; eid: EntityId)
    update_entity(eid) <| @( eid, cmp )
        cmp |> remove_decs_template`AI_need()
        cmp |> apply_decs_template([[AI_simple]])

[decs(stage = update)]
def AI_simple_update(p: Pos; var v: Vel; a: AI_simple; e: Enemy)
    var to = float2(0.0, 0.0)
    query() <| $(p: Player; u: Unit; pl_pos: Pos)
        to = pl_pos.p
    let dir = (to - p.p) / 0.1
    let dir_sq = length_sq(dir)
    let vel = normalize(dir) * e.speed
    let vel_sq = length_sq(vel)
    if vel_sq < dir_sq
        v.v = vel
    else
        v.v = dir
