extends "res://npcs/npc.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	dialogues = ["sage_intro", "sage_introrepeat", "sage_introgiftrepeat"]
	dialogue_inc = [0]
	
	#base.get_node("gui/dialogue").connect("purchased", self, "_on_nextline")


func dialogue_event(thing):
	pass

