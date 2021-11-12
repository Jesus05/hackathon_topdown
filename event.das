require daslib/decs_boost

[decs_template]
struct Event_AI_need
    empty: bool

[decs_template]
struct Event_chassis_need
    empty: bool

[decs_template]
struct Event_body_need
    empty: bool

[decs_template]
struct Event_shoot
    owner: EntityId
    body: EntityId
    damage_mod: float