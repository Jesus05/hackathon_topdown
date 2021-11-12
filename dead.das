require daslib/media
require daslib/decs_boost
require ecs_templates

require explosion

def delete_unit(chassis_eid: EntityId; eid: EntityId&)
    delete_entity(chassis_eid)
    delete_entity(eid)

[decs(stage = update)]
def dead(u: Unit; var eid: EntityId; p: Pos)
    if u.health <= 0.0
        create_explosion(p.p, u.size * 1.3, float2(0.0, 0.0))
        delete_unit(u.chassis, eid)