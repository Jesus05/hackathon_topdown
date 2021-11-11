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
struct Drawable
    empty: bool

[decs_template]
struct Shootable
    cooldown: float

[decs_template]
struct Player
    empty: bool


[decs_template]
struct Shoot
    life: float
    from: float2
    to: float2