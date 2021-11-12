require daslib/media
require daslib/decs_boost
require ecs_templates

require bullet

def create_shoot(pos: float2; dir: float2; vel: float2; var owner: EntityId; var body: EntityId; damage_mod: float; size: float)
    create_bullet(pos, pos + dir, vel, owner, damage_mod)
    return