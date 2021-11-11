require daslib/media
require daslib/decs_boost
require ecs_templates
require camera

[export]
def create_player()
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let pos = float2(0.0, 0.0)
        let vel = float2(0.0, 0.0)
        cmp |> apply_decs_template([[Pos p = pos]])
        cmp |> apply_decs_template([[Vel v = vel]])
        cmp |> apply_decs_template([[Player]])
        cmp |> apply_decs_template([[Camera]])
        cmp |> apply_decs_template([[Drawable]])
        cmp |> apply_decs_template([[Shootable cooldown = 0.0]])