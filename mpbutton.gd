
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	get_node("Normal").show()
	get_node("Hover").hide()
	get_node("Pressed").hide()


func _on_MultiplayerButton_pressed():
	get_node("Normal").hide()
	get_node("Hover").show()
	get_node("Pressed").hide()
	
	
func _on_MultiplayerButton_focus_enter():
	get_node("Normal").hide()
	get_node("Hover").hide()
	get_node("Pressed").show()
	get_node("../SamplePlayer").play("Active")

func _on_MultiplayerButton_mouse_enter():
	get_node("Normal").hide()
	get_node("Hover").show()
	get_node("Pressed").hide()
	get_parent().get_child(0).play("Hover")


func _on_MultiplayerButton_mouse_exit():
	get_node("Normal").show()
	get_node("Hover").hide()
	get_node("Pressed").hide()
