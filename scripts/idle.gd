extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var host
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func enter(_host, params):

	host = _host



func update(host, delta):
	pass
	
func exit(new_state, new_params):
	get_node("../../Current_State").add_child(new_state)
	host.current_state = new_state
	host.current_state.enter(host, new_params)
	queue_free()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
