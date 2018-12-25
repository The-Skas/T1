extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	
	# Initialization here Globals!
	Globals.timer = Timer.new()
	add_child(Globals.timer)
	Globals.timer.wait_time = 30
	Globals.timer.one_shot = true
	Globals.timer.start()
	####
	Globals.Class.Player = load("res://scripts/Player.gd")
	print(Globals.Class.Player)
	####
	get_node("Stage/Foreground/Mother").goal = "Dining"
	get_node("Camera")
	pass

	set_process(true)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
var rotate = 0.0
var positions
func _process(delta):
	pass


func rewind():
	

	Globals.is_rewinding = true
	Globals.rewind(self)
	Globals.end_rewind(self)

	Globals.is_rewinding = false
	

	Globals.timer.start()
	