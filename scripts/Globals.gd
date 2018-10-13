extends Node

#text interface
var tie



#Timer
var timer
var camera
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


