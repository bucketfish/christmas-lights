extends "res://npcs/npc.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	dialogues = ["fir_intro", "fir_beforesled", "fir_nothing"]
	dialogue_inc = [0, 1]

func dialogue_event(thing):
	pass
