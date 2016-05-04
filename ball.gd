
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	randomize()
	self.set_pos(Vector2(512, 300))
	var theta = randf()*PI
	
	self.set_linear_velocity(Vector2(200,130))


