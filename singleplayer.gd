
extends Node2D

onready var padleft = get_node("PadLeft")
onready var padrigth = get_node("PadRigth")
onready var ball = get_node("ball")
onready var labelrigth = get_node("LabelRight")
onready var labelleft = get_node("LabelLeft")
onready var playerwins = get_node("PlayerWins")
onready var timer = get_node("RespawnTime")
onready var home = get_node("Home")
onready var exit = get_node("Exit")
onready var reset_time = get_node("ResetTime")

var scoreai = 0
var scoreplayer = 0
var epsilon1 = 30
var epsilon2 = 40
var dir
var maxpoints = 1
var gameend = false

# member variables here, example:
# var a=2
# var b="textvar"

func ai():
	if ball.get_pos().y + epsilon2 < padleft.get_pos().y:
		padleft.set_pad_velocity(500)
		padleft.set_up_pressed(true)
		padleft.set_down_pressed(false)
	elif ball.get_pos().y - epsilon2 > padleft.get_pos().y:
		padleft.set_pad_velocity(500)
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
	if not gameend:
		score()
	ai()

func check_end_of_game():
	if scoreai == maxpoints:
		playerwins.set_text("Computer Wins")
		get_node("Square").show()
		gameend = true
		reset_time.start()
	if scoreplayer == maxpoints:
		playerwins.set_text("Player Wins")
		get_node("Square").show()
		gameend = true
		reset_time.start()

func score():
	var x = ball.get_pos().x
	if (x < 0):
		scoreplayer += 1
		check_end_of_game()
		if not gameend:
			dir = 1
			ball.reset()
			timer.start()
			
	elif (x > 1024) and not gameend:
		scoreai += 1
		check_end_of_game()
		if not gameend:
			dir = -1
			ball.reset()
			timer.start()
	labelleft.set_text(str(scoreai))
	labelrigth.set_text(str(scoreplayer))
	
	
	

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	padleft.set_pad_velocity(600)
	playerwins.set_text("")
	timer.set_wait_time(1)
	home.hide()
	exit.hide()



func _on_PadLeft_body_enter( body ):
	if body == ball:
		ball.increase_velocity_y(0.5*padleft.get_linear_velocity().y)


func _on_PadRigth_body_enter( body ):
	if body == ball:
		ball.increase_velocity_y(0.5*padrigth.get_linear_velocity().y)


func _on_RespawnTime_timeout():
	ball.reset_velocity(dir)
	timer.stop()


func _on_ResetTimer_timeout():
	playerwins.hide()
	home.show()
	exit.show()


func _on_Home_pressed():
	get_tree().change_scene("res://home.xscn")


func _on_Exit_pressed():
	get_tree().quit()


func _on_Home_mouse_enter():
	home.get_child(0).set_scale(Vector2(3.2,3.2))


func _on_Home_mouse_exit():
	home.get_child(0).set_scale(Vector2(3,3))


func _on_Exit_mouse_enter():
	exit.get_child(0).set_scale(Vector2(3.2,3.2))


func _on_Exit_mouse_exit():
	exit.get_child(0).set_scale(Vector2(3,3))
