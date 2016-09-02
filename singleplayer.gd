
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
onready var camera = get_node("Camera")

var scoreai = 0
var pause = false
var scoreplayer = 0
var dir = 1
var maxpoints = 1
var gameend = false
var paused = false

# member variables here, example:
# var a=2
# var b="textvar"


func _input(event):
	if event.is_action_pressed("ui_pause"):
		pause()
		
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
	padleft.ai(ball.get_pos().y)
	
	shaketime += delta
	if shake:
		set_pos(Vector2(2*cos(15*shaketime + PI), 2*sin(-15*shaketime)))
		if 15*shaketime > 2*PI:
			shake = false
			set_pos(Vector2(0,0))
	

func check_end_of_game():
	if scoreai == maxpoints:
		playerwins.set_text("Computer Wins")
		gameend = true
		reset_time.start()
	if scoreplayer == maxpoints:
		playerwins.set_text("Player Wins")
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
			sounds.play("score")
	elif (x > 1024) and not gameend:
		scoreai += 1
		check_end_of_game()
		if not gameend:
			dir = -1
			ball.reset()
			timer.start()
			sounds.play("score")
	labelleft.set_text(str(scoreai))
	labelrigth.set_text(str(scoreplayer))

var shaketime = 0
var shake = false
	
	
	
	

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	padleft.set_pad_velocity(600)
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
		get_node("Background/Bg1").show()
		get_node("Background/Bg2").hide()

	else:
		get_node("Background/Bars2").show()
		get_node("Background/Bars1").hide()
		get_node("Background/Space").hide()
		get_node("Background/Bg2").show()
		get_node("Background/Bg1").hide()

	randomize()
	var rand = randf()
	if rand > 0.5:
		get_node("Music1").play()
	else:
		get_node("Music2").play()
	randomize()
	var rand = randf()
	if rand > 0.5:
		get_node("ball/BlueBall").show()
		get_node("ball/RedBall").hide()
	else:
		get_node("ball/BlueBall").hide()
		get_node("ball/RedBall").show()




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

func _on_ball_body_enter( body ):
	sounds.play("hit")
	if body == get_node("BoundUpper") or body == get_node("BoundBottom"):
		shake = true
		shaketime = 0
	


func _on_TutorialTime_timeout():
	get_node("Tutorial").hide()
	
func pause():
	if paused:
		get_node("Pause").hide()
		exit.hide()
		home.hide()
		ball.set__pause(false)
		padleft.set__pause(false)
		padrigth.set__pause(false)
		paused = false
		if ball.get_stored_velocity() == Vector2(0,0):
			timer.start()
	else:
		get_node("Pause").show()
		exit.show()
		home.show()
		ball.set__pause(true)
		padleft.set__pause(true)
		padrigth.set__pause(true)
		paused = true
		var timeLeft = timer.get_time_left()
		if timeLeft > 0:
			timer.stop()
			timer.set_wait_time(timeLeft)

func _on_HomeButton_pressed():
	get_tree().change_scene("res://home.xscn")

func _on_ExitButton_pressed():
	get_tree().quit()
