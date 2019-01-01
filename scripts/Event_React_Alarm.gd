extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

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
	logic =  Globals.events.has("mom_dead")

	if(logic):
		get_tree().paused = true
		var paradox = get_node("/root/Root/CanvasLayer/Paradox")
		var noir_effect = get_node("/root/Root/CanvasLayer/FX_Noir")
		paradox.show()
		noir_effect.show()
	else:
		return null

func rewind():
	get_tree().paused = false
	var noir_effect = get_node("/root/Root/CanvasLayer/FX_Noir")
	var paradox = get_node("/root/Root/CanvasLayer/Paradox")
	paradox.hide()
	noir_effect.hide()
	done = false
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
