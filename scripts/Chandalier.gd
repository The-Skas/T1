extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var start_chand_pos
var start_shadow_scale 
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	start_chand_pos = get_node("Chand").position
	start_shadow_scale = get_node("Fall/Shadow").scale
#	self.fall()
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func fall():
	var chand = get_node("Chand")
	
	get_node("Tween").interpolate_property(chand, "position", null, get_node("Fall").position,1.8, Tween.TRANS_EXPO, Tween.EASE_IN)

	var shadow = get_node("Fall").get_node("Shadow")
	get_node("Tween").interpolate_property(shadow, "scale", null, shadow.scale * 2.3, 1.8,Tween.TRANS_EXPO, Tween.EASE_IN)
	
	get_node("Tween").start()

func _on_Tween_tween_completed(object, key):
	Globals.camera.shake(0.2, 20, 5)
	$Chand/Crash.play()
	$Chand/Crash2.play()
	$Chand/Crash3.play()
	$Chand/Crash4.play()	
		

	pass # replace with function body




	
func rewind():
	get_node("Chand").position = start_chand_pos 
	get_node("Fall/Shadow").scale = start_shadow_scale 
	self.fall()
	
