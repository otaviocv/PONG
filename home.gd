
extends Node2D
var time = 0.0
var stages = 1

# member variables here, example:
# var a=2
# var b="textvar"

func _process(delta):
	pass
		
func _ready():
	set_process(false)


func _on_SinglePlayerButton_pressed():
	get_tree().change_scene("res://singleplayer.xscn")

func _on_MultiplayerButton_pressed():
	get_tree().change_scene("res://multiplayer.xscn")

func _on_ExitButton_pressed():
	get_tree().quit()
