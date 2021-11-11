require daslib/media
require daslib/decs_boost

[export]
def prepare_background()
    background <- create_image(10000, 10000)
    prepare_spiral(background)
    set_background()

[decs_template]
struct Background
    empty: bool

var background : Image

[decs(stage = draw_layer0)]
def draw_background(b: Background; eid: EntityId)
    if !background.valid
        delete_entity(eid)
    else
        let x = float(/*get_screen_width()/2*/ - background.width / 2)
        let y = float(/*get_screen_height()/2*/ - background.height / 2)
        background |> draw_image(x, y, make_color(0.4, 0.4, 0.4, 1.0))

def prepare_spiral(var img: Image&)
    img |> make_image_color_transparent(img |> get_pixel(0, 0))
    let some_const = 0.05
    let k = 1.0
    let center = float2(float(img.width/2), float(img.height/2))
    var i = 0.0
    while (i < 4000.0)
        let phi = float(i)*some_const
        let r = k*float(i)
        let x = r*cos(phi) + center.x
        let y = r*sin(phi) + center.y
        img |> set_pixel(int(x), int(y), make_color(1.0, 1.0, 1.0, 1.0))
        i += 0.1

def set_background()
    create_entity <| @ ( eid, cmp )
        cmp |> set("eid", eid)
        apply_decs_template(cmp, [[Background]])

