extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func interact():
	print("Im a real table!")
	get_node("Sprite").modulate = Color(154,30,30,1.0)

func rewind():
		get_node("Sprite").modulate = Color(1.0,1.0,1.0,1.0)