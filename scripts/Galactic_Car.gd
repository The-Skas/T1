extends Node2D
tool
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
func play(anim):
	match anim:
		"left":
			$AnimatedSprite.animation = "right"
			$AnimatedSprite.transform.scaled(Vector2(-1,1))
			$AnimatedSprite.rotation_degrees = 70
			print("yay i eez animating right dude")
			
		"top":
			$AnimatedSprite.animation = "forward"
			$AnimatedSprite.transform.scaled(Vector2(1,1))
			print("yay i eez animating forward dude")		