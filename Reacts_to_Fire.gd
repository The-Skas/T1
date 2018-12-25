extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (bool) var do_once = true
var done = false
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func outcome():
	if(do_once and done):
		return null
		
	var logic;
	logic =  Globals.events.has("mom_burn") 

	if(logic):
		done = true
		var mom = get_node("../../../")
		mom.kill()
		mom.get_node("Effects/Burn").visible = true
		
		
	else:
		return null
		
func rewind():
	done = false
	get_node("../../../Effects/Burn").visible = false
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
