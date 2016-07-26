
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass



func _on_SinglePlayerButton_pressed():
	get_tree().change_scene("res://singleplayer.xscn")

func _on_MultiplayerButton_pressed():
	get_tree().change_scene("res://multiplayer.xscn")

func _on_ExitButton_pressed():
	get_tree().quit()
