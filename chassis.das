require daslib/media
require daslib/decs_boost
require ecs_templates

require globals
require event

struct ChassisBounds
    health: float2
    speed: float2
    name: string

var chassis: array<ChassisBounds>

def prepare_chassis()
    chassis |> push([[ChassisBounds health = float2(5.0, 7.0),    speed = float2(300.0, 400.0), name = "hover"]])
    chassis |> push([[ChassisBounds health = float2(10.0, 15.0),  speed = float2(200.0, 300.0), name = "wheel"]])
    chassis |> push([[ChassisBounds health = float2(20.0, 40.0),  speed = float2(100.0, 150.0), name = "tracks"]])
    chassis |> push([[ChassisBounds health = float2(80.0, 160.0), speed = float2(0.0, 0.0),     name = "pillar"]])

def create_random_chassis()
    let rnd = random_float(g_seed)
    let len = chassis |> length()
    for i in range (len)
        if rnd <= float((i+1)) / float(len)
            let health = chassis[i].health[0] + random_float(g_seed) * (chassis[i].health[1] - chassis[i].health[0])
            let speed = chassis[i].speed[0] + random_float(g_seed) * (chassis[i].speed[1] - chassis[i].speed[0])
            create_chassis(health, speed)
            break

def create_chassis(h: float; s: float)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        cmp |> apply_decs_template([[Chassis speed = s, health = h, equiped = false]])

[decs(stage = event)]
def chassis_setter(a: Event_chassis_need; eid: EntityId; var u: Unit)
    let unit_eid = eid
    let finded = find_query() <| $(var c: Chassis; eid: EntityId)
        if c.equiped
            return false
        u.chassis = eid
        c.equiped = true
        update_entity(unit_eid) <| @( eid, cmp )
            cmp |> remove_decs_template`Event_chassis_need()
        u.health += c.health
        u.health_max += c.health
        u.speed = c.speed
        return true
    if !finded
        create_random_chassis()
        
