extends KinematicBody2D

var master = true


const MAX_SPEED = 3.0
const ACCEL = 33
const DEACCEL = 10
var vel = Vector2(0 , 0)
var acc = Vector2(0 , 0)
var last_vel_length = 0

var max_health = 10
var health = 10

var tween
var raycast

#
var can_change_level = true
#actions_timeline
var i_actions = 0
var actions = []
var actions_timeline = []
var start_pos = Vector2(-100, 0)
var start_scene = "Lower_Floor"

func _ready():
	
	tween = get_node("Tween")
	raycast = get_node("RayCast2D")
	raycast.add_exception(self)
	raycast.set_enabled(false)
	
	if(master):
		get_node("Area2D").connect("body_enter", self, "_on_body_enter")
		print("Start pos: ", start_pos)
		set_process_input(true)
	else:
		get_node("Sprite").set_opacity(0.3)
		set_process_input(false)
		
	set_process(true)
	set_process_input(true)

func _interact(var isMaster):
	raycast.force_raycast_update()
	if(raycast.is_colliding()):
		var collider = raycast.get_collider()
		print(collider.get_name())
		var root = collider.get_parent().get_parent()
		if(root.has_method("interact")):
			actions.append("interact")
			root.interact(isMaster)
			
			
func _input(event):
	#We needd to use _input because Input.is_key_pressed, fires every frame. And
	#action_pressed only fires once!
	
	#Master here refers to the Current active clone... Is there an alternative way to do this?
	#For now, stick to this, I dont see an issue.
	if(master):
		if(event.is_action_pressed("ui_select") and Globals.timer.get_time_left() >= 0):
			raycast.force_raycast_update()
			if(raycast.is_colliding()):
				var collider = raycast.get_collider()
				print(collider.get_name())
				var root = collider.get_parent().get_parent()
				if(root.has_method("interact")):
					actions.append("_interact")
					root.interact(true)
					#globals.time_events["next"].append([root, globals.timer.get_time_left()])
				elif(collider.has_node("Interactable")):
					collider.get_node("Interactable").interact(true)

		
		if(event.is_action_pressed("rewind")):
			var root = get_node("/root/Root")
			root.rewind()
			
			

func _on_body_enter(collider):
	#if(collider extends globals.Player and collider != self):
		collider.queue_free()
		print("Playerz")
		
#Movement:
	
var is_trying_to_move = false
func move_right(delta):
	is_trying_to_move = true
	vel.x += ACCEL * delta
	
func move_left(delta):
	vel.x -= 1 
	raycast.rotate(-90)

func move_up(delta):
	vel.y -= 1
	raycast.rotate(180)
	
func move_down(delta):
	vel.y += 1
	raycast.rotate(0)



func _process(delta):
	


		

	is_trying_to_move = false
	if master:
	
		actions = []
		acc = Vector2(0.0,0.0)
		if(Input.is_action_pressed("attack")):
			attack()
			actions.append("attack")
		if(Input.is_action_pressed("move_right")):

			is_trying_to_move = true
			acc.x = 1

			#Which choice (A) :
			#A	Append value of delta 
			#B	OR Change to only use vel values
			actions.append("move_right")
		if(Input.is_action_pressed("move_left")):
			is_trying_to_move = true
			acc.x = -1
			
			actions.append("move_left")		
		if(Input.is_action_pressed("move_up")):
			is_trying_to_move = true
			acc.y = -1

			actions.append("move_up")
		if(Input.is_action_pressed("move_down")):
			is_trying_to_move = true
			acc.y = 1
			actions.append("move_down")
		
	
		#accelarate
		acc = acc.clamped(1.0)
		vel += acc * ACCEL * delta
		
		#decellarate
		var dir = vel.normalized()
		vel -= dir * DEACCEL * delta		
		var _dir = vel.normalized()
		
		#stops the jitter of inifnite deceleration wobble
		if(dir.x > 0 && _dir.x < 0 || dir.x < 0 && _dir.x > 0):
			vel.x = 0
			vel.y = 0
		

		

		actions_timeline.append([actions, delta])

	#Need to redfine the structure to make use of functions with variables
	else:
		if( i_actions < actions_timeline.size()):
			for action in actions_timeline[i_actions][0]:
	
				if(action == "_interact"):
					call(action, false)
				else:
					call(action)
	
			i_actions += 1
			pass
			
	#Shared functionality	

	vel = vel.clamped(MAX_SPEED)
	
	#Move at end, does it cause an issue? Initially found at start
	if(actions_timeline.empty()):	
		self.start_pos = self.position
	#	self.start_scene = get_node("/root/Root/Stage").get_child(0).get_name()
	var remainder = move_and_collide(vel)
		


# Has rewind but is not inherting from Rewindable... Confusing
func rewind():
	if(self.master == true):
		var clone = self.duplicate()
		print("****Callin master!****")
		clone.master = false
		clone.set_name("Clone")
		clone.actions_timeline = self.actions_timeline
		self.actions_timeline = []
		
		clone.start_pos = self.start_pos
		clone.set_pos(clone.start_pos)
		clone.start_scene = self.start_scene
		var foreground = get_node("/root/Root/Stage/"+self.start_scene+"/Foreground")
		foreground.add_child(clone)
		#Overwrite old pos
		self.start_pos = self.get_pos()
		self.start_scene = get_node("/root/Root/Stage").get_child(0).get_name()
		
	else:
		print("*****Callin Slave*****")
		self.set_pos(start_pos)
		var foreground = get_node("/root/Root/Stage/"+self.start_scene+"/Foreground")
		foreground.add_child(self)
		
		
		
	i_actions = 0
	
	
	
