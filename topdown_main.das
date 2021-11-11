require daslib/media
require daslib/decs_boost
// options debugger            // uncomment for debug in VS Code
// require daslib/debug        // uncomment for debug in VS Code

[decs_template]
struct Pos
    p: float2

[decs_template]
struct Vel
    v: float2

[decs_template]
struct Background
    img_idx: int

var images : array<Image>

def set_background(image_index : int)
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        apply_decs_template(cmp, [[Background img_idx = image_index]])

// 'initialize' runs once when game starts and every hot-reload
[export]
def initialize
    set_window_title("TopDown")
    let idx = images |> length()
    images |> emplace(create_image(10000, 10000))
    prepare_spiral(images[idx])
    set_background(idx)
    return

// this function is called to update game data,
// dt - time elapsed since the previous update (in seconds)
[export]
def act(dt: float)
    if get_key(VK_ESCAPE)
        schedule_quit_game()
    return

// this function will be called every frame after 'act',
// you can draw anything in this function

def prepare_spiral(var img: Image&)
    debug("{img.valid} {img.width} {img.height}")
    let some_const = 0.05
    let k = 1.0
    let center = float2(float(img.width/2), float(img.height/2))
    debug("{center.x} {center.y}")
    var i = 0.0
    while (i < 4000.0)
        let phi = float(i)*some_const
        let r = k*float(i)
        let x = r*cos(phi) + center.x
        let y = r*sin(phi) + center.y
        img |> set_pixel(int(x), int(y), 0xFFFFFF)
        i += 0.1
    
def draw_spiral(center: float2)
    let some_const = 0.05
    let k = 1.0
    var i = 0.0
    var bound = float4(0.0, 0.0, 0.0, 0.0)
    while (i < 4000.0)
        let phi = float(i)*some_const
        let r = k*float(i)
        let x = r*cos(phi) + center.x
        let y = r*sin(phi) + center.y
        set_pixel(x, y, 0xFFFFFF)
        bound.x = min(bound.x, x)
        bound.y = min(bound.y, y)
        bound.z = max(bound.z, x)
        bound.w = max(bound.w, y)
//        rect(x-2.0, y-2.0, 4.0, 4.0, 0xFFFFFF)
        i += 0.1
//    debug("bounds x in {bound.x} - {bound.z} y in {bound.y} - {bound.w}")

[decs(stage = draw)]
def draw_background(b: Background; eid: EntityId)
    if (images |> length() <= b.img_idx)
        delete_entity(eid)
    else
        let x = float(get_screen_width()/2 - images[b.img_idx].width / 2)
        let y = float(get_screen_height()/2 - images[b.img_idx].height / 2)
        images[b.img_idx] |> draw_image(x, y, 0xFFFFFF)

[export]
def draw
    //draw_spiral(float2(float(get_screen_width()/2), float(get_screen_height()/2)))
    decs_stage("draw")
    return
