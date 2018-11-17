extends Node



var host
var event_on_complete = null


#
#
# STATE CODE
#
#


func enter(_host, params):
	host = _host
	if(params.has("event_end")):
		event_on_complete = params["event_end"]


func update(host, delta):
	pass


func exit(new_state, new_params):
	get_node("../../Current_State").add_child(new_state)
	host.current_state = new_state
	host.current_state.enter(host, new_params)
	
	if(event_on_complete):
		get_parent().get_parent().get_node("Event").this_happened(event_on_complete)	
	queue_free()
		#debug
#		draw_polyline(positions, Color(0,1.0,1.0), 5.0)
#		update()
#	else:
		#Bad code design.
#		$AnimatedSprite/AnimationPlayer.pick_animation(Vector2(0,0))



