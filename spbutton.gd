extends Node

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Button_pressed():
	get_parent().get_parent().get_child(5).play("Active")
	get_tree().change_scene("res://singleplayer.xscn")
