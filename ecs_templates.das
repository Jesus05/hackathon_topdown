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
    health: float
    health_max: float

[decs_template]
struct Shootable
    cooldown: float
    cd_time: float
    damage: float

[decs_template]
struct Player
    empty: bool

[decs_template]
struct Bullet
    owner: EntityId
    size: float
    damage: float
    from: float2 //debug
    to: float2 //debug

[decs_template]
struct Enemy
    speed: float

[decs_template]
struct Explosion
    size: float
    created_at: float

[decs_template]
struct Life
    l: float

[decs_template]
struct Spawner
    current: uint
    max: uint
    spawn_every: float
    last_spawn: float

[decs_template]
struct EnemySpawner : Spawner {}

[decs_template]
struct PlayerSpawner : Spawner
    pos: float2
    lives: uint

[decs_template]
struct AI_simple_move
    empty: bool

[decs_template]
struct AI_simple_shoot
    empty: bool

[decs_template]
struct AI_need
    empty: bool