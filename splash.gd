
extends Node2D

var time = 0
var stages = 1
func _process(delta):
	time += delta
	if stages == 0:
		pass
	elif stages == 1:
		get_node("Splash1").set_opacity((sin(2*time + 3*PI/2)+1)*0.5)
		print(sin(time + 3*PI/2))
		if sin(2*time+3*PI/2) >= 0.99:
			stages += 1
			time = 0
	elif stages == 2:
		get_node("Splash1").set_opacity(1)
		stages += 1
		time = 0
	elif stages == 3:
		get_node("Splash1").set_opacity(cos(2*time))
		if cos(time) < 0:
			stages += 1
			time = 0
			get_node("Splash1").hide()
	elif stages == 4:
		get_node("Splash2").set_opacity(sin(time))
		if sin(time) > 0.99:
			stages += 1
			time = 0
	elif stages == 5:
		stages += 1
		time = 0
	elif stages == 6:
		get_node("Splash2").set_opacity(cos(2*time))
		if cos(time) < 0:
			stages += 1
			time = 0
			get_node("Splash2").show()
	elif stages == 7:
		get_tree().change_scene("res://home.xscn")

func _ready():
	get_node("Splash1").set_opacity(0)
	get_node("Splash2").set_opacity(0)
	set_process(true)
	

