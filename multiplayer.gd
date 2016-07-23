
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
onready var sounds = get_node("sounds")

var scoreleft = 0
var scoreright = 0
var dir = 1
var maxpoints = 11
var gameend = false
var paused = false

# member variables here, example:
# var a=2
# var b="textvar"

func _input(event):
	if event.is_action_pressed("ui_pause"):
		pause()
	
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
	if not gameend:
		score()
		

func check_end_of_game():
	if scoreleft == maxpoints:
		playerwins.set_text("Player 1 Wins")
		get_node("Square").show()
		gameend = true
		reset_time.start()
	if scoreright == maxpoints:
		playerwins.set_text("Player 2 Wins")
		get_node("Square").show()
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
			sounds.play("score")
	elif (x > 1024) and not gameend:
		scoreleft += 1
		check_end_of_game()
		if not gameend:
			dir = -1
			ball.reset()
			timer.start()
			sounds.play("score")
	labelleft.set_text(str(scoreleft))
	labelrigth.set_text(str(scoreright))
	
	

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	playerwins.set_text("")
	ball.reset()
	timer.start()
	get_node("TutorialTime").start()
	home.hide()
	exit.hide()
	randomize()
	var rand = randf()
	if rand > 0.5:
		get_node("Background/Bars1").show()
		get_node("Background/Space").show()
		get_node("Background/Bars2").hide()
	else:
		get_node("Background/Bars2").show()
		get_node("Background/Bars1").hide()
		get_node("Background/Space").hide()


func _on_PadLeft_body_enter( body ):
	if body == ball:
		ball.increase_velocity_y(0.5*padleft.get_linear_velocity().y)


func _on_PadRigth_body_enter( body ):
	if body == ball:
		ball.increase_velocity_y(0.5*padrigth.get_linear_velocity().y)


func _on_RespawnTime_timeout():
	ball.reset_velocity(dir)
	timer.stop()
	timer.set_wait_time(1)


func _on_Exit_pressed():
	get_tree().quit()


func _on_ResetTime_timeout():
	playerwins.hide()
	home.show()
	exit.show()

func _on_Exit_mouse_enter():
	get_node("sounds").play("Hover")
	exit.get_child(0).set_scale(Vector2(3.2,3.2))

func _on_Exit_mouse_exit():
	get_node("sounds").play("Active")
	exit.get_child(0).set_scale(Vector2(3,3))

func _on_Home_pressed():
	get_node("sounds").play("Active")
	get_tree().change_scene("res://home.xscn")

func _on_Home_mouse_enter():
	get_node("sounds").play("Hover")
	home.get_child(0).set_scale(Vector2(3.2,3.2))

func _on_Home_mouse_exit():
	home.get_child(0).set_scale(Vector2(3,3))


func _on_ball_body_enter( body ):
	sounds.play("hit")


func _on_TutorialTime_timeout():
	get_node("TutorialLabels").hide()
	
func pause():
	if not gameend:
		if paused:
			get_node("Square").hide()
			get_node("Pause").hide()
			exit.hide()
			ball.set__pause(false)
			padleft.set__pause(false)
			padrigth.set__pause(false)
			paused = false
			if ball.get_stored_velocity() == Vector2(0,0):
				timer.start()
		else:
			get_node("Square").show()
			get_node("Pause").show()
			exit.show()
			ball.set__pause(true)
			padleft.set__pause(true)
			padrigth.set__pause(true)
			paused = true
			var timeLeft = timer.get_time_left()
			if timeLeft > 0:
				timer.stop()
				timer.set_wait_time(timeLeft)
				

		