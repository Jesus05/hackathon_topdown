require daslib/media
require daslib/decs_boost
require ecs_templates

let PLAYER_WEAPON_COOLDOWN = 0.2

[export]
def create_player(pos: float2)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let vel = float2(0.0, 0.0)
        cmp |> apply_decs_template([[Pos p = pos]])
        cmp |> apply_decs_template([[Vel v = vel]])
        cmp |> apply_decs_template([[Player]])
        cmp |> apply_decs_template([[Camera]])
        cmp |> apply_decs_template([[Unit color = make_color(0.0, 1.0, 0.0, 1.0), size = 20.0, health = 10.0]])
        cmp |> apply_decs_template([[Shootable cooldown = PLAYER_WEAPON_COOLDOWN, cd_time = 0.0, damage = 1.0]])