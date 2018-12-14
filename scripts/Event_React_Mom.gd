extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (bool) var logic

func _ready():
	pass
	# Called when the node is added to the scene for the first time.
	# Initialization here



func react(events):
	for child in $Level_1.get_children():
		var outcome = child.outcome()
		if(outcome):
			return outcome

	return null
	pass
	# Get current Location ...

	#Evaluate for every event were looking for
	#if true, return the Action to occur....
	#	return State.new.Move("Object_to_move to")
	#		   State.new.Stun(0.5)
	#Or? Perform it ourselves.
func rewind():
	for child in self.get_children():
		if(child.has_method("rewind")):
				child.rewind()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
