extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
#	get_tree().paused = true 
#	set_process_input(true)
	pass

func _input(event):
	if(Globals.player.pause_mode == PAUSE_MODE_STOP and event.is_action_pressed("ui_select")):
		get_node("AnimationPlayer").play("Comic Fade Out")
		Globals.player.pause_mode = PAUSE_MODE_PROCESS

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
