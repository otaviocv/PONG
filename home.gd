
extends Node2D
var time = 0.0
var stages = 0

# member variables here, example:
# var a=2
# var b="textvar"

func _process(delta):
	stages = 0
	time += delta
	if stages == 0:
		get_node("EmptyBackground1").set_opacity(sin(time/1.5))
		if sin(time/1.5) > 1:
			stages += 1
			time = 0
	elif stages == 1:
		if time > 0.5:
			stages += 1
			time = 0
	elif stages == 2:
		get_node("EmptyBackground1").set_opacity(cos(time/1.5))
		if cos(time/1.5) < 0:
			stages+=1
			time = 0
		
		
	if time > 5:
		get_node("EmptyBackground1").show()
	if time > 10:
		get_node("EmptyBackground2").show()

func _ready():
	get_node("EmptyBackground1").show()
	get_node("EmptyBackground1").set_opacity(0)
	get_node("EmptyBackground2").show()
	get_node("EmptyBackground2").set_opacity(0)
	set_process(true)


func _on_SinglePlayerButton_pressed():
	get_tree().change_scene("res://singleplayer.xscn")

func _on_MultiplayerButton_pressed():
	get_tree().change_scene("res://multiplayer.xscn")

func _on_ExitButton_pressed():
	get_tree().quit()
