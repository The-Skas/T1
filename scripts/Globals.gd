extends Node

#text interface
var tie

#gets root node
onready var root = get_node("/root/Root")


#Timer
var timer
onready var camera = get_node("/root/Root/Camera")
#Global TIme Events
#	- Used for Player.gd Mainly, when "Interact" is pressed... I think lol
var time_events = {
	next = [],
	curr = []
}


#Custom classes
var Player = preload("res://Scripts/Player.gd")

# Shared Functions
func rewind(entity):
	var children = entity.get_children()
	for child in children:
		if child.has_method("rewind"):
			child.rewind()


