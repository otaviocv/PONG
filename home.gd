
extends Node2D
var time = 0.0
var splash = true

# member variables here, example:
# var a=2
# var b="textvar"

func _process(delta):
	time += delta
	if splash:
		get_node("Splash").set_opacity(cos(2*time))
		if cos(2*time) < 0:
			splash = false
			get_node("Splash").hide()
	pass

func _ready():
	get_node("Splash").set_opacity(1)
	set_process(true)


func _on_SinglePlayerButton_pressed():
	get_tree().change_scene("res://singleplayer.xscn")

func _on_MultiplayerButton_pressed():
	get_tree().change_scene("res://multiplayer.xscn")

func _on_ExitButton_pressed():
	get_tree().quit()
