extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var padvelocity = 650
var up_pressed = false 
var down_pressed = false
var epsilon1 = 30
var epsilon2 = 40
func ai(y):

	if y + epsilon2 < get_pos().y:
		set_pad_velocity(500)
		set_up_pressed(true)
		set_down_pressed(false)
	elif y - epsilon2 > get_pos().y:
		set_pad_velocity(500)
		set_down_pressed(true)
		set_up_pressed(false)
	elif get_pos().y + epsilon1 < get_pos().y:
		set_pad_velocity(200)
		set_up_pressed(true)
		set_down_pressed(false)
	elif y - epsilon1 > get_pos().y:
		set_pad_velocity(200)
		set_down_pressed(true)
		set_up_pressed(false)
	elif y < get_pos().y:
		set_pad_velocity(50)
		set_up_pressed(true)
		set_down_pressed(false)
	elif y > get_pos().y:
		set_pad_velocity(50)
		set_down_pressed(true)
		set_up_pressed(false)
	else:
		set_down_pressed(false)
		set_up_pressed(false)



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

func set_pad_velocity(v):
	padvelocity = v

func _ready():
	set_fixed_process(true)
	self.set_mass(15)

func set__pause(state):
	if state:
		set_fixed_process(false)
	else:
		set_fixed_process(true)
