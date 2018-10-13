extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 50
var goal = null
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)
	pass
func moveTo(entityName):

	return get_node("/root/Root/Navigation").get_simple_path(get_node("/root/Root/Stage/Foreground/Mother").position, get_node("/root/Root/Stage/Foreground/"+entityName).position + 	get_node("/root/Root/Stage/Foreground/"+entityName+"/Nav").position * get_node("/root/Root/Stage/Foreground/"+entityName).scale,true)

var GOAL_THRESHOLD = 10
func hasArrived():
	if(positions != null):
		if((self.position - positions[1]).length() < GOAL_THRESHOLD):
			true
		else:
			return false
	
var positions
func _process(delta):
	if(hasArrived()):
		goal = null
	if(goal):
		positions = moveTo(goal)
		var dir = positions[1] - self.position
		move_and_slide(dir.normalized() * speed)
		
		#debug
		draw_polyline(positions, Color(0,1.0,1.0), 5.0)
		update()

func _draw():
	print("yoyoyo")
	print(positions)
	if(positions != null):
		draw_polyline(positions, Color(1.0,1.0,1.0))
		


var dead = false
func kill():
	#kill the mom
	if(not dead):
		dead = true
		get_node("AnimatedSprite").rotate(90)
		self.modulate = Color( 0.2, 0.2, 0.2, 1.0)
		
func rewind():
	dead = false
	self.modulate = Color(1,1,1,1)
	get_node("AnimatedSprite").rotation = 0