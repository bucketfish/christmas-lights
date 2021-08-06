extends Node2D

var inrange = false
var canspeak = true

onready var base = get_node("/root/game")
onready var dialogue = get_node("/root/game/dialogue/dialogue")

export var npcname: String
# Called when the node enters the scene tree for the first time.

var dialogues = []
var dialogue_inc = []
var dialoguenum = 0 setget dialogue_setget

func _ready():
	dialogue.connect("action", self, "dialogue_event")
	dialogue.connect("action", self, "dialogue_event_base")
	#base.get_node("gui/dialogue").connect("purchased", self, "_on_nextline")


func _on_text_body_entered(body):
	if body.is_in_group("player"):
		inrange = true


func _on_text_body_exited(body):
	if body.is_in_group("player"):
		inrange = false
		

func _input(event):
	if inrange && event.is_action_pressed("interact") && base.speaking == false:
		base.dialogue_set(dialogues[dialoguenum])
		#print(dialoguenum)
		if dialoguenum in dialogue_inc:
			dialoguenum += 1
			dialogue_setget(dialoguenum)

func dialogue_event_base(thing):
	if thing == "dialogue_nextline":
		dialoguenum += 1
		dialogue_setget(dialoguenum)

func dialogue_setget(val):
	base.npc_dialogue[npcname] = val
	dialoguenum = val

