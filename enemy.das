require daslib/media
require daslib/decs_boost
require ecs_templates

require event

let ENEMY_SPEED = 200.0

def create_enemy(pos: float2)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let vel = float2(0.0, 0.0)
        cmp |> apply_decs_template([[Pos p = pos]])
        cmp |> apply_decs_template([[Vel v = vel]])
        cmp |> apply_decs_template([[Enemy]])
        cmp |> apply_decs_template([[Unit color = make_color(1.0, 0.0, 0.0, 1.0), size = 15.0, health = 3.0, health_max = 3.0, speed = ENEMY_SPEED]])
        cmp |> apply_decs_template([[Shootable cooldown = 1.0, cd_time = 0.0, damage_mod = 1.0]])
        cmp |> apply_decs_template([[Event_AI_need]])
        cmp |> apply_decs_template([[Event_chassis_need]])
        cmp |> apply_decs_template([[Event_body_need]])