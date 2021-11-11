require daslib/media
require daslib/decs_boost
require ecs_templates

[decs(stage = update)]
def life_remover(var l: Life; eid: EntityId)
    if l.l <= 0.0
        delete_entity(eid)
    l.l -= get_delta_time()