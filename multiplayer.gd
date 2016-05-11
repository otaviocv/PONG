
extends Node2D

onready var padleft = get_node("PadLeft")
onready var padrigth = get_node("PadRigth")
onready var ball = get_node("ball")
# member variables here, example:
# var a=2
# var b="textvar"

func _input(event):
	
	#First Player
	
	if event.is_action_released("2playerup"):
		padleft.set_up_pressed(false)
	if event.is_action_released("2playerdown"):
		padleft.set_down_pressed(false)
	if event.is_action_pressed("2playerup"):
		padleft.set_up_pressed(true)
	if event.is_action_pressed("2playerdown"):
		padleft.set_down_pressed(true)
		
	# Second Player

	if event.is_action_released("1playerup"):
		padrigth.set_up_pressed(false)
	if event.is_action_released("1playerdown"):
		padrigth.set_down_pressed(false)
	if event.is_action_pressed("1playerup"):
		padrigth.set_up_pressed(true)
	if event.is_action_pressed("1playerdown"):
		padrigth.set_down_pressed(true)
	
func _fixed_process(delta):
	padleft.set_pos(Vector2(50, padleft.get_pos().y))
	padrigth.set_pos(Vector2(974, padrigth.get_pos().y))
	ball.increase_velocity_x(1.005)
	

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func collision_on_padleft( viewport, event, shape_idx ):
	ball.increase_velocity_y(padleft.get_linear_velocity().y)

func _on_PadRigth_input_event( viewport, event, shape_idx ):
	ball.increase_velocity_y(padrigth.get_linear_velocity().y)
