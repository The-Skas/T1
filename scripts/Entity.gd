tool
extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(Texture) var my_texture = null setget set_sprite
export(String) var my_name = "SnoopDog"
func set_sprite(texture):
	my_texture = texture
	if($Sprite != null):
		$Sprite.texture = texture
	update()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	if(not(my_texture == null)):
		$Sprite.texture = my_texture
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func interact():
	print("Im a real entity!")


func rewind():
		get_node("Sprite").modulate = Color(1.0,1.0,1.0,1.0)