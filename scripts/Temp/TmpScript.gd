extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var event_conditions = ["radio", "smoke"]
var state_conditions = ["MoveTo"]
export (bool) var do_once = false
var done = false
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func outcome():
	if(do_once and done):
		return null

	var logic;
	logic =  Globals.events.has("mom_radio")

	if(logic):
		done = true
		var _root = get_node("../../../")
		_root.get_node("AudioStreamPlayer2D").stop()
		_root.get_node("Particle_Music").emitting = false
		_root.toggle_radio = true

		_root.get_node("Event").this_happened("radio_off")

	else:
		return null

func rewind():
	done = false
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
