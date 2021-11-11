require daslib/media
require daslib/decs_boost
require ecs_templates

require shoot

[decs(stage = update)]
def user_shoot(var s: Shootable; pos: Pos; pl: Player)
    if s.cooldown > 0.0
        return
    if get_mouse_button(MB_LEFT)
        let mouse_screen_pos = get_mouse_position()
        let mouse_world_pos = screen_to_world(mouse_screen_pos)
        create_shoot(pos.p, mouse_world_pos)
        s.cooldown = 0.3