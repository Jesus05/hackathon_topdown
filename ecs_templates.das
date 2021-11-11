require daslib/decs_boost

[decs_template]
struct Pos
    p: float2

[decs_template]
struct Vel
    v: float2

[decs_template]
struct Camera
    empty: bool

[decs_template]
struct Unit
    color: uint
    size: float

[decs_template]
struct Shootable
    cooldown: float
    cd_time: float

[decs_template]
struct Player
    empty: bool

[decs_template]
struct Bullet
    owner: EntityId
    size: float
    from: float2 //debug
    to: float2 //debug

[decs_template]
struct Enemy
    empty: bool

[decs_template]
struct Explosion
    size: float
    created_at: float

[decs_template]
struct Life
    l: float