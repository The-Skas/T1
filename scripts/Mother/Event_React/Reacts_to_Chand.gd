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
	logic =  Globals.events.has("chand_fall") 

	if(logic):
		done = true
		var mom = get_node("../../../")

		mom.get_node("speech").reset()
		mom.get_node("speech").say("Oh my!!",0.05)
#		yield(get_tree().create_timer(2),"timeout")
		mom.get_node("speech").say("That was close..",0.05)

	else:
		return null
		
func rewind():
	done = false

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
