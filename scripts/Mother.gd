extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 50
var goal = null
var goal_position = null
var start_position
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)
	self.start_position = self.position
	#AI
	goal_position = self.position + $Goal.position
	goal_position = get_node("/root/Root/Navigation").get_simple_path(self.position, goal_position,true)[-1]

	pass
func moveTo(entityName):
	#	return get_node("/root/Root/Navigation").get_simple_path(self.position, get_node("/root/Root/Stage/Foreground/"+entityName).position + 	get_node("/root/Root/Stage/Foreground/"+entityName+"/Nav").position * get_node("/root/Root/Stage/Foreground/"+entityName).scale,true)
	return get_node("/root/Root/Navigation").get_simple_path(self.position, goal_position,true)

var GOAL_THRESHOLD = 5
func hasArrived():
	
	if(positions != null):
		if((self.position - goal_position).length() < GOAL_THRESHOLD):
			
			return true
		else:
			return false
	
var positions

## Entity velocity
var vel = Vector2(0,0)
func _process(delta):
	
	
	
	#Animation
	if(vel.length() > 0.1):

		$AnimatedSprite/AnimationPlayer.pick_animation(vel)

	
	
	#AI Node
	if(hasArrived()):
		print("Goal Done!")
		goal = null
		positions = null
		vel = Vector2(0,0)
	if(goal):
		
		positions = moveTo(goal)

		vel = positions[1] - self.position

		move_and_slide(vel.normalized() * speed)
		
		#debug
		draw_polyline(positions, Color(0,1.0,1.0), 5.0)
		update()
	else:
		#Bad code design.
		$AnimatedSprite/AnimationPlayer.pick_animation(Vector2(0,0))

func _draw():
	if(positions != null):
		draw_polyline(positions, Color(1.0,1.0,1.0))
		


var dead = false
func kill():
	#kill the mom
	print(Globals.is_rewinding)
	if(not dead and not Globals.is_rewinding):
		$AnimatedSprite/AudioStreamPlayer2D.play()
		dead = true
		get_node("AnimatedSprite").rotate(90)
		self.modulate = Color( 0.2, 0.2, 0.2, 1.0)
		
func rewind():
	dead = false
	self.modulate = Color(1,1,1,1)
	get_node("AnimatedSprite").rotation = 0
	self.position = self.start_position

func _on_Area2D_body_entered(body):
	print(body)
	if(body.get_parent().get_name() == "Chand" and body.get_name() == "Kill"):
		self.kill()
	pass # replace with function body
