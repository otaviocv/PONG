
extends SamplePlayer

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass




func _on_SinglePlayerButton_pressed():
	pass # replace with function body


func _on_SinglePlayerButton_focus_enter():
	play("Active")

func _on_SinglePlayerButton_mouse_enter():
	play("Hover")

func _on_MultiplayerButton_focus_enter():
	play("Active")

func _on_ExitButton_focus_enter():
	play("Active")

func _on_ExitButton_mouse_enter():
	play("Hover")

func _on_HomeButton_focus_enter():
	play("Active")
