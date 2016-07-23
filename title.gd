
extends Sprite

var x0 = 512
var y0 = 180
var arg = 0

func _fixed_process(delta):
	arg += delta
	set_pos(Vector2(x0, y0+10*sin(2.5*arg)))
	

func _ready():
	set_fixed_process(true)


