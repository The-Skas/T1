extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
## Entity velocity
var vel = Vector2(0,0)
var speed = 50
export (String) var goal = null
var goal_position = null
var start_position
var positions

var start_state = "Move"
var start_state_params = {"speed": speed, "move_to": "Dining"}
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)
	self.start_position = self.position
	$Current_State.add_child($State/Move.duplicate())
	current_state = $Current_State.get_child(0)
	current_state.enter(self, start_state_params)



	

var current_state 
func _process(delta):
	# What if the mother moves to a different area.. then 
	# different logic should be loaded for each area
	#	  
	var react_state = $Event_React.react(Globals.events)
	
	if( react_state):
		var new_state = $State.find_node(react_state["state"])
		current_state.exit(new_state.duplicate(), react_state["params"])
	
	
	

	#AI Node
	current_state.update(self,delta)
	
	move_and_slide(vel.normalized() * speed)
	
	#Animation
	if(vel.length() > 0.1):

		$AnimatedSprite/AnimationPlayer.pick_animation(vel)

	vel = Vector2(0,0)

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
	
	#AI 
	current_state.exit( $State/Move.duplicate(), start_state_params)

	
	for child in self.get_children():
		if(child.has_method("rewind")):
				child.rewind()


func _on_Area2D_body_entered(body):

	if(body.get_parent().get_name() == "Chand" and body.get_name() == "Kill"):
		self.kill()
	pass # replace with function body
