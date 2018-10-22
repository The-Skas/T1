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
const MIN_VEC_LENGTH = 1

func pick_animation(var vec):
	#assert(vec.class() == Vector2)
	var anim_to_play = ""
	var dir = vec.normalized()
	

	if(  dir.x > 0.5 ):
		anim_to_play= "Walk_Right"
	elif(  dir.x < -0.5 ):
		anim_to_play= "Walk_Left"
	elif(  dir.y >= 0.5 ):
		anim_to_play= "Walk_Down"
	elif(  dir.y <= -0.5 ):
		anim_to_play= "Walk_Up"

	
	if(vec.length() < MIN_VEC_LENGTH):
		anim_to_play = "Stand_Down"
		
	if( current_animation != anim_to_play):

		play(anim_to_play)