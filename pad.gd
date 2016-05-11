extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var padvelocity = 650
var up_pressed = false 
var down_pressed = false

func up():
	self.set_linear_velocity(Vector2(0,-padvelocity))
	
func down():
	self.set_linear_velocity(Vector2(0,padvelocity))

func stop():
	self.set_linear_velocity(Vector2(0,0))

func set_up_pressed(value):
	up_pressed = value

func set_down_pressed(value):
	down_pressed = value

func _fixed_process(delta):
	if down_pressed and up_pressed:
		pass
	elif up_pressed:
		up()
	elif down_pressed:
		down()
	if (not up_pressed) and (not down_pressed):
		stop()

func _ready():
	set_fixed_process(true)
	self.set_mass(15)
