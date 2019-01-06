extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (String) var reply = "test"
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func player_response():
	if(not Globals.events.has("paradox")):
		Globals.player.speech.force_say("*Click*", 0.1, 0.8)
	else:
		Globals.player.speech.force_say("the chrono-state of this timer is inconsistent..", 0.05,1)
		Globals.player.speech.say("The timer should have been on.", 0.04,1)	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
