extends "res://player/states/state.gd"

var speed = 50
export (String) var move_to = null
var goal_position = null
var start_position


func set_goal_pos(var pos):
	#assert

	goal_position = pos
	goal_position = get_node("/root/Root/Navigation").get_simple_path(host.position, goal_position,true)[-1]


func moveTo(entityName):
	#	return get_node("/root/Root/Navigation").get_simple_path(self.position, get_node("/root/Root/Stage/Foreground/"+entityName).position + 	get_node("/root/Root/Stage/Foreground/"+entityName+"/Nav").position * get_node("/root/Root/Stage/Foreground/"+entityName).scale,true)
	var _object = get_parent().get_parent().get_parent().get_node(entityName)
	if(_object != null):
		set_goal_pos(get_object_pos(_object))
		return get_node("/root/Root/Navigation").get_simple_path(host.position, goal_position,true)
	else:
		return self.position


var GOAL_THRESHOLD = 5
func hasArrived():

	if(positions != null):
		if((host.position - goal_position).length() < GOAL_THRESHOLD):

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

#
#
# STATE CODE
#
#


func enter(_host, params):
	speed = params["speed"]
	move_to = params["move_to"]
	.enter(_host, params)



func update(host, delta):

	#
	if(hasArrived()):

		move_to = null
		positions = null
		vel = Vector2(0,0)
		self.exit(get_node("../../State/Idle").duplicate(), {})
	else:

		positions = moveTo(move_to)

		vel = positions[1] - host.position

		host.vel += vel
		


func exit(new_state, new_params):
	.exit(new_state, new_params)
		#debug
#		draw_polyline(positions, Color(0,1.0,1.0), 5.0)
#		update()
#	else:
		#Bad code design.
#		$AnimatedSprite/AnimationPlayer.pick_animation(Vector2(0,0))



