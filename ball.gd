
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var vx = 350
var vy = 200

func increase_velocity_x(k):
	var vx = self.get_linear_velocity().x
	if vx > 0:
		self.set_linear_velocity(Vector2(vx*k, get_linear_velocity().y))
	else:
		self.set_linear_velocity(Vector2(vx*k, get_linear_velocity().y))
	# print("1:"+ str(self.get_linear_velocity().x))


func reset():
	self.set_pos(Vector2(512, 300))
	self.set_linear_velocity(Vector2(0, 0))

func reset_velocity(dir):
	var k = 0.28727
	vx = 350
	vy = rand_range(-k*vx,k*vx)
	self.set_linear_velocity(Vector2(dir*vx, vy))

	

func increase_velocity_y(k):
	var vy = self.get_linear_velocity().y
	self.set_linear_velocity(Vector2(get_linear_velocity().x, vy+k))

func _fixed_process(delta):
	vy = self.get_linear_velocity().y
	if vy > 1000:
		self.set_linear_velocity(Vector2(self.get_linear_velocity().x, 1000))
	elif vy < -1000:
		self.set_linear_velocity(Vector2(self.get_linear_velocity().x, -1000))
		

func _ready():
	set_fixed_process(true)
	# Called every time the node is added to the scene.
	# Initialization here
	reset()
	reset_velocity(1)



