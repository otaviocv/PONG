
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass




func _on_Button_mouse_enter():
	get_node("SINGLE PLAYER").set_scale(Vector2(0.45,0.45))


func _on_Button_mouse_exit():
	get_node("SINGLE PLAYER").set_scale(Vector2(0.4,0.4))


func _on_Button2_mouse_enter():
	get_node("MULTIPLAYER").set_scale(Vector2(0.45,0.45))


func _on_Button2_mouse_exit():
	get_node("MULTIPLAYER").set_scale(Vector2(0.4,0.4))


func _on_Exit_pressed():
	get_tree().quit()


func _on_Exit_mouse_enter():
	get_node("Exit/Label").set_scale(Vector2(3.5,3.5))


func _on_Exit_mouse_exit():
	get_node("Exit/Label").set_scale(Vector2(3,3))
