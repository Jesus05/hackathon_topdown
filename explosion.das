require daslib/media
require daslib/decs_boost
require ecs_templates

def create_explosion(pos: float2; size: float; normale: float2)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        let vel = float2(0.0, 0.0)
        cmp |> apply_decs_template([[Pos p = pos]])
        cmp |> apply_decs_template([[Explosion size = size, created_at = get_time_after_start()]])
        cmp |> apply_decs_template([[Life l = 0.4]])
    
[decs(stage = draw)]
def explosion_draw(s: Explosion; p: Pos)
    let red = move_to(1.0, 0.0, get_time_after_start() - s.created_at, 1.0)
    fill_circle(p.p.x, p.p.y, s.size, make_color(red, 0.0, 0.0, 1.0))
    return