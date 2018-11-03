extends KinematicBody2D


var master = true


const MAX_SPEED = 3.0
const ACCEL = 28
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

export(Vector2) var start_pos = Vector2(466.200012,305.3)
export(String) var start_scene = "Stage"
func _ready():

	tween = get_node("Tween")
	raycast = get_node("RayCast2D")
	raycast.add_exception(self)
	raycast.add_exception(get_node("Area2D"))
	raycast.set_enabled(false)

	if(master):
		self.start_pos = self.position
		get_node("Area2D").connect("body_enter", self, "_on_body_enter")

		
		set_process_input(true)
	else:
		get_node("Sprite").self_modulate.a = 0.5
		
		set_process_input(false)

	set_physics_process(true)
	set_process_input(true)

func interact():
	if(not self.master):
		queue_free()
		

func _interact():
	raycast.force_raycast_update()
	if(raycast.is_colliding()):
	
		var collider = raycast.get_collider()
		print(collider.get_name())
		var root = collider.get_parent()
		print(root.get_name())
		if(root.has_method("interact")):
			#If its not a Player, interact
			if(not(	root is Globals.Class.Player)):
				root.interact()
			else:
				root.interact() if master else 0
				


func _input(event):
	#We needd to use _input because Input.is_key_pressed, fires every frame. And
	#action_pressed only fires once!

	#Master here refers to the Current active clone... Is there an alternative way to do this?
	#For now, stick to this, I dont see an issue.
	if(master):
#		if(event.is_action_pressed("ui_select") and Globals.timer.get_time_left() >= 0):
#			raycast.force_raycast_update()
#			print(raycast.rotation)
#			if(raycast.is_colliding()):
#				print("Its colliding!")
#				var collider = raycast.get_collider()
#				print(collider.get_name())
#				var root = collider.get_parent()
#				print(root)
#				if(root.has_method("interact")):
#					actions.append("_interact")
#					root.interact()



		if(event.is_action_pressed("rewind")):
			var root = get_node("/root/Root")
			root.rewind()



func _on_body_enter(collider):
	#if(collider extends globals.Player and collider != self):
		collider.queue_free()
		print("Playerz")

#Movement:


func move_right():
	acc.x = 1
	raycast.rotation = -90
func move_left():
	acc.x = -1
	raycast.rotation = 90

func move_up():
	acc.y = -1
	raycast.rotation = -180

func move_down():
	acc.y = 1
	raycast.rotation = 0



func _physics_process(delta):

	acc = Vector2(0.0,0.0)

	if master:

		actions = []

		if(Input.is_action_just_pressed("ui_select")):
			self._interact()
			actions.append("_interact")
		if(Input.is_action_pressed("move_right")):


			#Which choice (A) :
			#A	Append value of delta
			#B	OR Change to only use vel values
			move_right()
			actions.append("move_right")
		if(Input.is_action_pressed("move_left")):
			move_left()
			actions.append("move_left")
		if(Input.is_action_pressed("move_up")):
			move_up()
			actions.append("move_up")
		if(Input.is_action_pressed("move_down")):
			move_down()
			actions.append("move_down")





		if(actions.size() > 0):
			pass
		actions_timeline.append([Globals.timer.get_time_left(), actions])
		
	#Need to redfine the structure to make use of functions with variables
	else:
		
		if(i_actions < actions_timeline.size() && actions_timeline[i_actions][0] > Globals.timer.get_time_left()):
			for action in actions_timeline[i_actions][1]:
				call(action)


			i_actions += 1

	#accelarate
	acc = acc.clamped(1.0)
	vel += acc * ACCEL * delta

	#decellarate
	var dir = vel.normalized()
	vel -= dir * DEACCEL * delta
	var _dir = vel.normalized()

	#stops the jitter of inifnite deceleration wobble
	if(dir.x > 0 && _dir.x < 0 || dir.x < 0 && _dir.x > 0 || dir.y < 0 && _dir.y > 0 || dir.y > 0 && _dir.y < 0):
		vel.x = 0
		vel.y = 0


	#Shared functionality
	vel = vel.clamped(MAX_SPEED)


	#Move at end, does it cause an issue? Initially found at start
	if(actions_timeline.empty()):
		self.start_pos = self.position
	#	self.start_scene = get_node("/root/Root/Stage").get_child(0).get_name()
	var remainder = move_and_slide(vel/delta)
	
	if(get_slide_collision(get_slide_count()-1)):
		vel = DEACCEL *vel * delta
		



# Has rewind but is not inherting from Rewindable... Confusing
func rewind():
	if(self.master == true):

		var clone = self.duplicate(15)

		clone.master = false
		clone.set_name("Clone")
		clone.actions_timeline = self.actions_timeline
		self.actions_timeline = []
		self.vel = Vector2(0,0)
		clone.start_pos = self.start_pos
		clone.position = clone.start_pos
		clone.start_scene = self.start_scene
		var foreground = get_node("/root/Root/"+self.start_scene+"/Foreground")
		foreground.add_child(clone)
		#Overwrite old pos
		self.start_pos = self.position
		self.start_scene = get_node("/root/Root/").get_child(0).get_name()

	else:

		self.position = start_pos
		var foreground = get_node("/root/Root/"+self.start_scene+"/Foreground")
		foreground.add_child(self)



	i_actions = 0



