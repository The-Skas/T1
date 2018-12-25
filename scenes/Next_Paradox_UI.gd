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
	logic =  Globals.events.has("radio_on")

	if(logic):
		done = true
		var ui_text = get_node("../../../Next_Paradox")
		ui_text.text = "Death By Chandalier"



	else:
		return null

func rewind():
	done = false
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
