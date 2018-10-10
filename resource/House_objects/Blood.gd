extends "res://Entity/Interactable.gd"
class dialogue:
	var x
func _ready():
	description = [[  #One dialogue 
					  ["Fresh blood..\n",0.125, 0.5], 
					  ["No sign of a body", 0.075, 0],
				   ],[ #Second dialogue
	     			  ["No sign of the baby though",0.075, 0.25], 
					  ["...", 0.1, 0],
				]]

