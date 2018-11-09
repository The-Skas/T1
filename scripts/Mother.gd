extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 50
export (String) var goal = null
var goal_position = null
var start_position

func set_goal_pos(var pos):
	#assert
	$Goal.position = pos
	goal_position = pos
	goal_position = get_node("/root/Root/Navigation").get_simple_path(self.position, goal_position,true)[-1]


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)
	self.start_position = self.position
	goal = null
	#AI


	pass
func moveTo(entityName):
	#	return get_node("/root/Root/Navigation").get_simple_path(self.position, get_node("/root/Root/Stage/Foreground/"+entityName).position + 	get_node("/root/Root/Stage/Foreground/"+entityName+"/Nav").position * get_node("/root/Root/Stage/Foreground/"+entityName).scale,true)
	var _object = get_parent().get_node(entityName)
	if(_object != null):
		set_goal_pos(get_object_pos(_object))
		return get_node("/root/Root/Navigation").get_simple_path(self.position, goal_position,true)
	else:
		return self.position

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

func get_object_pos(object):
	# Means they have a preferred pos
	var _position = object.position
	if(object.has_node("Nav")):
		_position += object.get_node("Nav").position * object.scale
	return _position
		
func _process(delta):
	# What if the mother moves to a different area.. then 
	# different logic should be loaded for each area
	#	  
	if( Globals.events.has("alarm")):
		goal = "Kitchen_1"

	
	
	#Animation
	if(vel.length() > 0.1):

		$AnimatedSprite/AnimationPlayer.pick_animation(vel)

	
	
	#AI Node
	if(hasArrived()):

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

	if(body.get_parent().get_name() == "Chand" and body.get_name() == "Kill"):
		self.kill()
	pass # replace with function body
