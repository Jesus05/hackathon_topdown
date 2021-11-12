require daslib/media
require daslib/decs_boost
require ecs_templates

require globals
require event

struct BodyBounds
    health: float2
    speed_mod: float2
    damage: float2
    cooldown: float2
    bullet_speed: float2
    bullet_spread: float2 //percent of 45 degree
    bullet_count: float2
    type_: BodyType

var bodys: array<BodyBounds>

def prepare_bodys()
    bodys |> push([[BodyBounds health = float2(5.0, 10.0), speed_mod = float2(1.0, 1.2), damage = float2(0.5, 1.2), cooldown = float2(0.1, 0.2), bullet_speed = float2(300.0, 400.0), bullet_spread = float2(0.1, 0.3), bullet_count = float2(1.0, 1.0), type_ = BodyType assault]])
    bodys |> push([[BodyBounds health = float2(1.0, 2.0), speed_mod = float2(0.2, 0.8), damage = float2(10.0, 20.0), cooldown = float2(1.0, 2.0), bullet_speed = float2(500.0, 600.0), bullet_spread = float2(0.0, 0.1), bullet_count = float2(1.0, 1.0), type_ = BodyType sniper]])
    bodys |> push([[BodyBounds health = float2(10.0, 20.0), speed_mod = float2(0.1, 0.4), damage = float2(20.0, 50.0), cooldown = float2(0.5, 1.0), bullet_speed = float2(300.0, 400.0), bullet_spread = float2(0.0, 0.1), bullet_count = float2(1.0, 1.0), type_ = BodyType rocket]])
    bodys |> push([[BodyBounds health = float2(5.0, 5.0), speed_mod = float2(1.1, 1.5), damage = float2(0.5, 2.0), cooldown = float2(0.3, 0.4), bullet_speed = float2(400.0, 500.0), bullet_spread = float2(0.7, 1.0), bullet_count = float2(5.0, 10.0), type_ = BodyType shotgun]])
    bodys |> push([[BodyBounds health = float2(5.0, 5.0), speed_mod = float2(1.1, 1.5), damage = float2(0.1, 0.2), cooldown = float2(0.0, 0.0), bullet_speed = float2(0.0, 0.0), bullet_spread = float2(0.0, 0.0), bullet_count = float2(1.0, 1.0), type_ = BodyType laser]])

def get_random_range(min: float; max: float)
    return min + random_float(g_seed) * (max - min)

def create_random_body()
    let rnd = random_float(g_seed)
    let len = bodys |> length()
    for i in range (len)
        if rnd <= float((i+1)) / float(len)
            let health = get_random_range(bodys[i].health[0], bodys[i].health[1])
            let speed_mod = get_random_range(bodys[i].speed_mod[0], bodys[i].speed_mod[1])
            let damage = get_random_range(bodys[i].damage[0], bodys[i].damage[1])
            let cooldown = get_random_range(bodys[i].cooldown[0], bodys[i].cooldown[1])
            let bullet_speed = get_random_range(bodys[i].bullet_speed[0], bodys[i].bullet_speed[1])
            let bullet_spread = get_random_range(bodys[i].bullet_spread[0], bodys[i].bullet_spread[1])
            let bullet_count = get_random_range(bodys[i].bullet_count[0], bodys[i].bullet_count[1])
            create_body(health, speed_mod, damage, cooldown, bullet_speed, bullet_spread, bullet_count, bodys[i].type_)
            break

def create_body(h: float; s: float; d: float; c:float; bullet_speed:float; bullet_spread:float; bullet_count:float; t: BodyType)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        cmp |> apply_decs_template([[Body health = h, speed_mod = s, damage = d, cooldown = c, bullet_speed = bullet_speed, bullet_spread = bullet_spread, bullet_count = bullet_count, equiped = false, type_ = t]])

[decs(stage = event)]
def body_setter(a: Event_body_need; eid: EntityId; var u: Unit; var s: Shootable)
    let unit_eid = eid
    let finded = find_query() <| $(var b: Body; eid: EntityId)
        if b.equiped
            return false
        u.body = eid
        b.equiped = true
        update_entity(unit_eid) <| @( eid, cmp )
            cmp |> remove_decs_template`Event_body_need()
        u.health += b.health
        u.health_max += b.health
        u.speed *= b.speed_mod
        return true
    
    if !finded
        create_random_body()