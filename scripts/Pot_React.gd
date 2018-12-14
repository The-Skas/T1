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
	logic =  Globals.events.has("mom_alarm")

	if(logic):
		done = true
		var kitchen = get_node("../../../")
		kitchen.get_node("timer/Sound_Alarm").stop()
		kitchen.get_node("timer").alarm_time = null
		kitchen.get_node("../../Top/pot_smoke").set_visible(false)
	#	Turn off heat	
		kitchen.get_node("pot").on = false
		kitchen.get_node("pot").region_rect = Rect2(0, 0, 32, 32)
	else:
		return null

func rewind():
	done = false
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
