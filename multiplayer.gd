
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

var scoreleft = 0
var scoreright = 0
var dir = 1
var maxpoints = 1
var gameend = false

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
	ball.increase_velocity_x(1.0035)
	if not gameend:
		score()
		

func check_end_of_game():
	if scoreleft == maxpoints:
		playerwins.set_text("Player 1 Wins")
		gameend = true
		reset_time.start()
	if scoreright == maxpoints:
		playerwins.set_text("Player 2 Wins")
		gameend = true
		reset_time.start()

func score():
	var x = ball.get_pos().x
	if (x < 0):
		scoreright += 1
		check_end_of_game()
		if not gameend:
			dir = 1
			ball.reset()
			timer.start()
	elif (x > 1024) and not gameend:
		scoreleft += 1
		check_end_of_game()
		if not gameend:
			dir = -1
			ball.reset()
			timer.start()
	labelleft.set_text(str(scoreleft))
	labelrigth.set_text(str(scoreright))
	
	

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	playerwins.set_text("")
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


func _on_Home_released():
	get_tree().change_scene("res://home.xscn")

func _on_Exit_pressed():
	get_tree().quit()


func _on_Home_pressed():
	get_tree().change_scene("res://home.xscn")


func _on_ResetTime_timeout():
	playerwins.hide()
	home.show()
	exit.show()
