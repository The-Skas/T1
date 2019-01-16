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
	logic =  Globals.events.has("chand_kill_mom")

	if(logic):
		done = true
		Globals.player.speech.say("What a de-Lightful way to go... *Sigh*", 0.1, 2)
		Globals.player.speech.say("It seems her death is causing a paradox, which means..", 0.05, 2)
#		Globals.player.speech.say("she musn't die.",0.08,1)
#		Globals.player.speech.say("Its going to be one of those cases, I can tell.", 0.08, 2)

	else:
		return null


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
