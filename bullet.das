require daslib/media
require daslib/decs_boost
require ecs_templates

require explosion

let BULLET_SPEED = 300.0

def create_bullet(from: float2; to: float2; vel_plus: float2; var owner: EntityId; damage: float)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let life = 2.0
        let dir_to_target = to - from
//        var vel = normalize(dir_to_target) * BULLET_SPEED
        let d = dot(normalize(dir_to_target), normalize(vel_plus))
//        let k = length(dir_to_target) / length(vel)
//        let target = to - vel_plus * k
        let vel = normalize(dir_to_target) * BULLET_SPEED * (1.0 + d)
        let target_place = from + vel * life
//        let d = dot(normalize(target_place), normalize(to))
//        debug("dot {d} tp {target_place} to {to}")
//        let from = f + normalize(to - f) * 20.0
        cmp |> apply_decs_template([[Bullet from = from, to = target_place, owner = owner, size = 3.0, damage = damage]])
        cmp |> apply_decs_template([[Vel v = vel]])
        cmp |> apply_decs_template([[Pos p = from]])
        cmp |> apply_decs_template([[Life l = life]])
    return

[decs(stage = draw_debug)] //debug
def shoot_draw(s: Bullet; p: Pos; l: Life)
    let nvel = normalize(s.to - s.from)
    let from = p.p
    let to = from + nvel * BULLET_SPEED * l.l
    line(from.x, from.y, to.x, to.y, make_color(1.0, 0.0, 1.0, 1.0))

[decs(stage = draw)]
def bullet_draw(s: Bullet; p: Pos)
    fill_circle(p.p.x, p.p.y, s.size, make_color(1.0, 1.0, 1.0, 1.0))
    return

[decs(stage = update)]
def bullet_collision(unit_pos: Pos; var u: Unit; eid: EntityId)
    let unit_eid = eid
    query() <| $(bullet_pos: Pos; b: Bullet; eid: EntityId)
        if unit_eid == b.owner
            return
        let len = length(unit_pos.p - bullet_pos.p)
        let size_sum = u.size + b.size
        if len < size_sum
            u.health -= b.damage
            let normale = normalize(bullet_pos.p - unit_pos.p)
            let pos = unit_pos.p + normale * u.size
            create_explosion(pos, 3.0, normale)
            delete_entity(eid)
    return
