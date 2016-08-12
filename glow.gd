
extends AnimatedSprite
var time = 0
# member variables here, example:
# var a=2
# var b="textvar"
func _process(delta):
	var initopacity = 0.55
	var finalopacity = 1
	time += delta
	set_opacity(cos(4*time)*(finalopacity-initopacity)/2 + initopacity)
	# print(str(get_opacity()) + " " +  str(get_name()))
	

func _ready():
	set_opacity(1.0)
	set_process(true)


