
extends Node2D
var time = 0.0
var stages = 1

# member variables here, example:
# var a=2
# var b="textvar"

func _process(delta):
	print(delta)
	time += delta
	if stages == 0:
		pass
	elif stages == 1:
		get_node("EmptyBackground1").set_opacity(sin(time/1.5))
		if sin(time/1.5) > 1:
			stages += 1
			time = 0
	elif stages == 2:
		if time > 0.5:
			stages += 1
			time = 0
	elif stages == 3:
		get_node("EmptyBackground1").set_opacity(cos(time/1.5))
		if cos(time/1.5) < 0:
			stages += 1
			time = 0
			get_node("EmptyBackground1").hide()
	elif stages == 4:
		get_node("EmptyBackground2").set_opacity(sin(time/1.5))
		if sin(time/1.5) > 1:
			stages += 1
			time = 0
	elif stages == 5:
		if time > 0.5:
			stages += 1
			time = 0
	elif stages == 6:
		get_node("EmptyBackground2").set_opacity(cos(time/1.5))
		if cos(time/1.5) < 0:
			stages += 1
			time = 0
			get_node("EmptyBackground1").show()
	elif stages == 7:
		get_node("Game").set_opacity(sin(time/1.5))
		if sin(time/1.5) > 1:
			stages += 0
		
		
func _ready():
	set_process(false)


func _on_SinglePlayerButton_pressed():
	get_tree().change_scene("res://singleplayer.xscn")

func _on_MultiplayerButton_pressed():
	get_tree().change_scene("res://multiplayer.xscn")

func _on_ExitButton_pressed():
	get_tree().quit()
