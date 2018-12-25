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
	pass

var timer
var fire
func outcome():
	if(do_once and done):
		return null

	var logic;
	logic =  Globals.events.has("fire")

	if(logic):
		fire = get_node("../../../")
		fire.visible = true


		timer.connect("timeout",self,"burn_mother") 
		timer.set_wait_time(2)
		timer.one_shot = true
		#timeout is what says in docs, in signals
		#self is who respond to the callback
		#_on_timer_timeout is the callback, can have any name
		add_child(timer) #to process
		timer.start() #to start
	else:
		return null

func burn_mother():
	print("Mother dead :(")
	get_node("/root/Root/Event").this_happened("mom_dead")
	
func rewind():
	fire.visible = false
	done = false
	timer.stop()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
