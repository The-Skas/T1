extends "res://Entity/Interactable.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var anim 
func _ready():
	anim = get_node("AnimatedSprite")
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func interact(var isMainPlayer):
	anim.stop()
	anim.set_animation("open_close")
	anim.set_frame(0)
	anim.play("open_close")
	print("Do i work")
	.interact(isMainPlayer)
	
