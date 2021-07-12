extends Node2D

var inrange = false

onready var base = get_node("/root/game")

export var npcname: String
# Called when the node enters the scene tree for the first time.

var dialogues = ["fir_intro", "fir_beforesled", "fir_aftersled", "fir_nothing"]
var dialoguenum = 0 setget dialogue_setget

func _ready():
	base.get_node("gui/dialogue").connect("purchased", self, "_on_nextline")


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		inrange = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		inrange = false
		
func _on_nextline(line):
	if line == 'fir_aftersled':
		dialoguenum = 3
		dialogue_setget(3)
		base.gain_ability("slide")

func _input(event):
	if inrange && event.is_action_pressed("interact") && base.speaking == false:
		base.dialogue_set(dialogues[dialoguenum])
		#print(dialoguenum)
		if dialoguenum in [0]:
			dialoguenum += 1
			dialogue_setget(dialoguenum)


func dialogue_setget(val):
	base.npc_dialogue[npcname] = val
	dialoguenum = val
	print("set fir's dialogue number to " + str(dialoguenum))
