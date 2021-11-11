require daslib/media
require daslib/decs_boost
require ecs_templates

require explosion

[decs(stage = update)]
def dead(u: Unit; eid: EntityId; p: Pos)
    if u.health <= 0.0
        create_explosion(p.p, u.size * 1.3, float2(0.0, 0.0))
        delete_entity(eid)