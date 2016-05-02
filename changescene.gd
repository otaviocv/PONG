extends Button

var currentScene = null 

# member variables here, example:
# var a=2
# var b="textvar"
# create a function to switch between scenes 
func setScene(scene):
   #clean up the current scene
   currentScene.queue_free()
   #load the file passed in as the param "scene"
   var s = ResourceLoader.load(scene)
   #create an instance of our scene
   currentScene = s.instance()
   # add scene to root
   get_tree().get_root().add_child(currentScene)

func change_scence():
	var atual = get_node("Button")
	if Button.is_action_pressed("atual"):
		setScene("SinglePlayer")

	


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


