extends AnimationPlayer

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

#Animation should only be called once 

func pick_animation(var vec):
	#assert(vec.class() == Vector2)
	var anim_to_play = ""
	var dir = vec.normalized()
	if(  dir.x > 0.5 ):
		if(vec.length() > 5):
			anim_to_play= "Walk_Right"
		else:
			anim_to_play= "Stand_Right"
	elif(  dir.x < 0.5 ):
		if(vec.length() > -0.5):
			anim_to_play= "Walk_Left"
		else:
			anim_to_play= "Stand_Left"
	elif(  dir.y >= 0.5 ):
		if(vec.length() > 5):
			anim_to_play= "Walk_Down"
		else:
			anim_to_play= "Stand_Down"
	elif(  dir.y <= -0.5 ):
		if(vec.length() > -0.5):
			anim_to_play= "Walk_Up"
		else:
			anim_to_play= "Stand_Up"
			
	if( not self.is_playing(anim_to_play)):
		play(anim_to_play)
			
	print(dir)
		