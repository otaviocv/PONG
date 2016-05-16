
extends Node2D

onready var padleft = get_node("PadLeft")
onready var padrigth = get_node("PadRigth")
onready var ball = get_node("ball")
onready var labelrigth = get_node("LabelRight")
onready var labelleft = get_node("LabelLeft")
var scoreleft = 0
var scoreright = 0
var epsilon1 = 30
var epsilon2 = 40

# member variables here, example:
# var a=2
# var b="textvar"

func ai():
	if ball.get_pos().y + epsilon2 < padleft.get_pos().y:
		padleft.set_pad_velocity(400)
		padleft.set_up_pressed(true)
		padleft.set_down_pressed(false)
	elif ball.get_pos().y - epsilon2 > padleft.get_pos().y:
		padleft.set_pad_velocity(400)
		padleft.set_down_pressed(true)
		padleft.set_up_pressed(false)
	elif ball.get_pos().y + epsilon1 < padleft.get_pos().y:
		padleft.set_pad_velocity(200)
		padleft.set_up_pressed(true)
		padleft.set_down_pressed(false)
	elif ball.get_pos().y - epsilon1 > padleft.get_pos().y:
		padleft.set_pad_velocity(200)
		padleft.set_down_pressed(true)
		padleft.set_up_pressed(false)
	elif ball.get_pos().y < padleft.get_pos().y:
		padleft.set_pad_velocity(50)
		padleft.set_up_pressed(true)
		padleft.set_down_pressed(false)
	elif ball.get_pos().y > padleft.get_pos().y:
		padleft.set_pad_velocity(50)
		padleft.set_down_pressed(true)
		padleft.set_up_pressed(false)
	else:
		padleft.set_down_pressed(false)
		padleft.set_up_pressed(false)

func _input(event):
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
	ball.increase_velocity_x(1.0035)
	score()
	ai()
	
func score():
	var x = ball.get_pos().x
	if (x < 0):
		scoreright += 1
		ball.reset(1)
	elif (x > 1024):
		scoreleft += 1
		ball.reset(-1)
	labelleft.set_text(str(scoreleft))
	labelrigth.set_text(str(scoreright))
	
	

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	padleft.set_pad_velocity(600)
	# Called every time the node is added to the scene.
	# Initialization here
	pass



func _on_PadLeft_body_enter( body ):
	if body == ball:
		ball.increase_velocity_y(0.5*padleft.get_linear_velocity().y)


func _on_PadRigth_body_enter( body ):
	if body == ball:
		ball.increase_velocity_y(0.5*padrigth.get_linear_velocity().y)
