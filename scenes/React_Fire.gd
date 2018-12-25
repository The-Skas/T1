extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (bool) var do_once = false
var done = false
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	timer = Timer.new()
	get_node("/root/").add_child(timer)
	fire = get_node("../../../")
	pass

var timer
var fire
var func_state
func outcome():
	if(do_once and done):
		return null

	var logic;
	logic =  Globals.events.has("fire")

	if(logic):
		func_state = do_logic()
	else:
		return null
func do_logic():
	fire = get_node("../../../")
	fire.visible = true
	done = true
	
	yield(get_tree().create_timer(1.0), "timeout")
	burn_mother()
	
	
func burn_mother():
	print("Mother dead :(")
	get_node("/root/Root/Event").this_happened("mom_burn")
	
func rewind():

	if(func_state != null and func_state.has_method("resume")):
        func_state = func_state.resume()
	
	fire.visible = false
	done = false

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
