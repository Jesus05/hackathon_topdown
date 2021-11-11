require daslib/media
require daslib/decs_boost
require ecs_templates

[decs(stage = update)]
def shootable_cooldown(var s: Shootable)
    s.cooldown -= get_delta_time()