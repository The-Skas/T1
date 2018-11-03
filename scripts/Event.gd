extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(String) var event_name 
export(float) var at_time

export(bool) var do_once = true
var done = false
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func this_happened(event_name):

	if(do_once and done):
		return
		
	Globals.events.append([event_name, Globals.timer.time_left])
	done = true
		
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
