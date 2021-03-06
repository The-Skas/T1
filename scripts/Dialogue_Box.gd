extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var tie = get_node("TextInterfaceEngine")
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	tie.set_color(Color(0,0,0))
	tie.connect("buff_end", self, "_on_buff_end")
	tie.connect("state_change", self, "_on_state_change")
	set_physics_process(true)
	pass

var stay_on_time = 1

var say_que = []

var MAX_DISTANCE_ALPHA = 500.0
var MIN_DISTANCE_ALPHA = 200.0
func _physics_process(delta):
	var player_dist = Globals.player.global_position
	var distance = self.get_parent().global_position.distance_to(player_dist)

	var alpha = distance / MAX_DISTANCE_ALPHA
	self.modulate.a = 1.0 - min(alpha, 1.0)
	if(distance < MIN_DISTANCE_ALPHA):
		self.modulate.a *=1.2



	if(curr_state == tie.STATE_WAITING and say_que.size() > 0):
		var _say = say_que.pop_front()
		tie.reset()
		tie.buff_text(_say[0], _say[1])
		tie.buff_silence(_say[2])
		tie.set_state(tie.STATE_OUTPUT)

func say(text, speed=0.02, new_stay_on_time = stay_on_time):
	say_que.append([text, speed, new_stay_on_time])

func reset():
	say_que.clear()
	tie.reset()
	
#		yield(get_tree().create_timer(2),"timeout")
#		tie.reset()


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

#extends Control
#
#onready var tie = get_node("panel/text_interface_engine")
#
#func select_demo(i):
#	tie.reset()
#	if(i == 1):
#		# "A Beautiful Song"
#		# by Henrique Alves
#		tie.set_color(Color(1,1,1))
#		# Buff text: "Text", duration (in seconds) of each letter
#		tie.buff_text("This is a song, ", 0.1)
#		tie.buff_text("lalala\n", 0.2)
#		# Buff silence: Duration of the silence (in seconds)
#		tie.buff_silence(1)
#		tie.buff_text("It is so beautiful, ", 0.1)
#		tie.buff_text("lalala\n", 0.2)
#		tie.buff_silence(1)
#		tie.buff_text("I love this song, ", 0.1)
#		tie.buff_text("lalala\n", 0.2)
#		tie.buff_silence(1)
#		tie.buff_text("But now I'll ", 0.1) # WAIT FOR THE DROP
#		tie.buff_text("DROP", 0.02) # ?????
#		tie.buff_silence(0.4)
#		tie.buff_text(" THE BASS\n", 0.02) # !!!!!
#		tie.buff_silence(0.4)
#		tie.buff_text("TVUVTUVUTUVU WOODBODBOWBDODBO TUUVUTVU WODWVDOOWDV WODOWVOOWDVOWVD DUBDUBDUBUDUDB OWVDOWVWDOWVDOWVDOWVDWVDOWVDOWVODV", 0.04) # I firmly believe this particular verse is my Magna Opus.
#	elif(i == 2):
#		tie.set_color(Color(1,1,0.3))
#		# If velocity is 0, than whole text is printed 
#		tie.buff_text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras semper finibus sapien, ut fringilla nulla vehicula ac. In hac habitasse platea dictumst. Nulla lobortis tempus sem vel lobortis. Mauris facilisis mollis nunc, vitae aliquet dui dictum id. Nullam ultricies facilisis interdum. Ut id semper eros, in lobortis diam. Nam consequat, dolor pharetra imperdiet finibus, lacus turpis tincidunt velit, ut fringilla ligula orci et justo. Praesent sagittis lectus eu metus faucibus aliquam. Donec sollicitudin porttitor massa a mollis. Nulla eleifend orci lacus, et tristique dui viverra eu. Sed nec mollis ligula. Quisque eu tellus libero. Nulla id hendrerit mauris.",0)
#	elif(i == 3):
#		tie.set_color(Color(0.3,1,1))
#		# Schedule an Input in the buffer, after all
#		# the text before it is displayed
#		tie.buff_text("Hey there!! What's your name?\n", 0.01)
#		tie.buff_input()
#	tie.set_state(tie.STATE_OUTPUT)
#
#func _ready():
#	# Add the demos in the list
#	get_node("demos_list").set_focus_mode(0)
#	get_node("demos_list").add_item("No demo")
#	get_node("demos_list").add_item("DEMO_Music")
#	get_node("demos_list").add_item("DEMO_Ipsum")
#	get_node("demos_list").add_item("DEMO_Input")
#
#	# Connect every signal to check them using the "print()" method
#	tie.connect("input_enter", self, "_on_input_enter")
#	tie.connect("buff_end", self, "_on_buff_end")
#	tie.connect("state_change", self, "_on_state_change")
#	tie.connect("enter_break", self, "_on_enter_break")
#	tie.connect("resume_break", self, "_on_resume_break")
#	tie.connect("tag_buff", self, "_on_tag_buff")
#	pass
#
#func _on_demos_list_item_selected( ID ):
#	select_demo(ID)
#
#func _on_input_enter(s):
#	print("Input Enter ",s)
#
#	tie.add_newline()
#	tie.buff_text("Oooh, so your name is " + s + "? What a beautiful name!", 0.01)
#	pass

func _on_buff_end():
	print("Buff End")
	pass

var curr_state = 0
func _on_state_change(i):
	curr_state = i
	if(i == tie.STATE_OUTPUT):
		visible = true

	elif(i == 0 ):
		visible = false




	

	print("State changed: ",i)
	pass

func rewind():
	tie.reset()
	curr_state = 0
	say_que.clear()
#func _on_enter_break():
#	print("Enter Break")
#	pass
#
#func _on_resume_break():
#	print("Resume Break")
#	pass
#
#func _on_tag_buff(s):
#	print("Tag Buff ",s)
#	pass
