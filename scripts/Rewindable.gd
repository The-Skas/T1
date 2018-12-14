extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var event = "Staticly assigned"
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass

func _process(delta):
	print(get_node("/root/Globals").events)
	pass
func rewind():

	var children = get_children()
	for child in children:
			if(child.has_method("rewind")):
				child.rewind()
				
	#Delete all previous events
	Globals.events = {}
				



