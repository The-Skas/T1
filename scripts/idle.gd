extends "res://player/states/state.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var MIN_WAIT_TIME_MS = 700
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

var start_time = 0
func enter(_host, params):
	.enter(_host, params)



func update(host, delta):
	pass
	
func exit(new_state, new_params):
	.exit(new_state, new_params)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
