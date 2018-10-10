extends Node

#text interface 
var tie



#Timer
var timer	
#Global TIme Events
#	- Used for Player.gd Mainly, when "Interact" is pressed... I think lol
var time_events = {
	next = [],
	curr = []
}


#Custom classes
var Player = preload("res://Scripts/Player.gd")


