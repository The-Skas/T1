extends Node
tool
#text interface
var tie

#gets root node
onready var root = get_node("/root/Root")


#Timer
var is_rewinding
var timer
onready var camera = get_node("/root/Root/Camera")
#Global TIme Events
onready var player = get_node("/root/Root/Stage/Foreground/Player")
#Used in Events

#Store a variable for all possible event types, and to
#throw an error if the event logic is checking for a NON Existing event
var events = {}


#Custom classes
var Class = {
	
}

# Shared Functions
func rewind(entity):
	var children = entity.get_children()
	for child in children:
		if child.has_method("rewind"):
			child.rewind()


