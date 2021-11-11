require daslib/media
require daslib/decs_boost
require ecs_templates

def create_shoot(from: float2; to: float2)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let life = 1.0
        cmp |> apply_decs_template([[Shoot life = life, from = from, to = to]])
    return

[decs(stage = update)]
def shoot_remover(var s: Shoot; eid: EntityId)
    if s.life <= 0.0
        delete_entity(eid)
    s.life -= get_delta_time()

[decs(stage = draw)]
def shoot_draw(var s: Shoot)
    line(s.from.x, s.from.y, s.to.x, s.to.y, make_color(1.0, 0.0, 1.0, 1.0))