require daslib/media
require daslib/decs_boost
require ecs_templates

let BULLET_SPEED = 300.0

def create_bullet(from: float2; to: float2)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let life = 2.0
        let vel = normalize(to - from) * BULLET_SPEED
        cmp |> apply_decs_template([[Bullet life = life, from = from, to = to]])
        cmp |> apply_decs_template([[Vel v = vel]])
        cmp |> apply_decs_template([[Pos p = from]])
    return

[decs(stage = update)]
def shoot_remover(var s: Bullet; eid: EntityId)
    if s.life <= 0.0
        delete_entity(eid)
    s.life -= get_delta_time()

[decs(stage = draw_debug)]
def shoot_draw(s: Bullet; p: Pos)
    let nvel = normalize(s.to - s.from)
    let from = p.p
    let to = from + nvel * BULLET_SPEED * s.life
    line(from.x, from.y, to.x, to.y, make_color(1.0, 0.0, 1.0, 1.0))

[decs(stage = draw)]
def bullet_draw(s: Bullet; p: Pos)
    fill_circle(p.p.x, p.p.y, 5.0, make_color(1.0, 1.0, 1.0, 1.0))
    return
