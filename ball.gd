
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func increase_velocity_x(k):
	var vx = self.get_linear_velocity().x
	if vx > 0:
		self.set_linear_velocity(Vector2(vx*k, get_linear_velocity().y))
	else:
		self.set_linear_velocity(Vector2(vx*k, get_linear_velocity().y))
	print("1:" + str(vx) + "|2:" + str(self.get_linear_velocity().x))

func increase_velocity_y(k):
	var vy = self.get_linear_velocity().y
	self.set_linear_velocity(Vector2(get_linear_velocity().x, vy+1000*k))
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	randomize()
	self.set_pos(Vector2(512, 300))
	var theta = randf()*PI
	
	self.set_linear_velocity(Vector2(350,130))


