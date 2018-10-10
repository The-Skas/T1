extends Area2D


export var change_level = "Main1"
export var position_node = "Player_Spawn"

func _ready():
	connect("body_enter", self, "_on_enemy_body_enter")
	print("I'm back baby!")

func _on_enemy_body_enter(body):
	if(body.get_name() == "Player"):
		print("My Parent is: ", get_parent().get_name())
		var old_player = get_parent().get_node("Foreground").get_node(body.get_name())

		var player = old_player.duplicate()
		var stage = get_parent().get_parent()

		var current_scene = get_parent()
		var change_to_scene = stage.get_node(change_level)
	
		current_scene.get_node("Foreground").remove_child(old_player)
		get_node("/root/Root").change_stage(change_level)
		
		#Copy over
		#actions_timeline
		player.i_actions = old_player.i_actions
		player.actions = old_player.actions
		player.actions_timeline = old_player.actions_timeline 
		player.start_pos = old_player.start_pos 
		player.start_scene = old_player.start_scene
		
		

		change_to_scene.get_node("Foreground").add_child(player)		
		
		var player_spawn = change_to_scene.get_node(position_node)
		player.set_pos(player_spawn.get_pos())
		print("player pos:", player.get_pos())
	else:
		var name = body.get_name()
		var node = get_parent().get_node("Foreground").get_node(name)
		if(node != null):
			if(node.get("can_change_level") == true):
				var old_player = get_parent().get_node("Foreground").get_node(body.get_name())
		
				var player = old_player.duplicate()
				var stage = get_parent().get_parent()
		
				var current_scene = get_parent()
				var change_to_scene = stage.get_node(change_level)
			
				current_scene.get_node("Foreground").remove_child(old_player)
				#get_node("/root/Root").change_stage(change_level)
				
				#Copy over
				#actions_timeline
				player.i_actions = old_player.i_actions
				player.actions = old_player.actions
				player.actions_timeline = old_player.actions_timeline 
				player.start_pos = old_player.start_pos 
				player.start_scene = old_player.start_scene
				player.master = old_player.master
				
				old_player.queue_free()
				change_to_scene.get_node("Foreground").add_child(player)		
				
				var player_spawn = change_to_scene.get_node(position_node)
				player.set_pos(player_spawn.get_pos())
		


	
