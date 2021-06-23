extends Control

onready var label = $NinePatchRect/MarginContainer/RichTextLabel
var showing = false
var current = ""
var count = 0
var dialogues = {
	"fir_intro": ["FIR_INTRO_1", "FIR_INTRO_2", "FIR_INTRO_3"],
	"fir_beforesled": ["FIR_BEFORESLED_1"],
	"fir_aftersled": ["FIR_AFTERSLED_1", "FIR_AFTERSLED_2", "FIR_AFTERSLED_3"],
	"fir_nothing": ["FIR_NOTHING_1", "FIR_NOTHING_2"]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	


func show_dialogue(name):
	visible = true
	showing = true
	current = name
	count = 0
	label.bbcode_text = tr(dialogues[name][count])
		
func _input(event):
	if event.is_action_pressed("dialogue_next") && showing:
		if count + 1 < dialogues[current].size():
			count += 1
			label.bbcode_text = tr(dialogues[current][count])
		else:
			showing = false
			visible = false
