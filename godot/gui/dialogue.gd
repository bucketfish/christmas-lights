extends Control

onready var label = $NinePatchRect/MarginContainer/VBoxContainer/RichTextLabel
onready var choice = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer
onready var cancel = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/cancel
onready var accept = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/accept
#onready var margin = $NinePatchRect/MarginContainer/VBoxContainer/MarginContainer

onready var base = get_node("/root/game")

signal giveberry(count)
signal purchased(nextline)

var showing = false
var current = ""
var count = 0
var state = 0  #0=none, 1=cancel, 2=gift
var dialogues = {
	"fir_intro": ["FIR_INTRO_1", "FIR_INTRO_2", "FIR_INTRO_3", 5, 'fir_aftersled'],
	"fir_beforesled": ["FIR_BEFORESLED_1", 5, 'fir_aftersled'],
	"fir_aftersled": ["FIR_AFTERSLED_1", "FIR_AFTERSLED_2", "FIR_AFTERSLED_3"],
	"fir_nothing": ["FIR_NOTHING_1", "FIR_NOTHING_2"]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	choice.visible = false

func show_dialogue(name):
	base.state = "dialogue"
	visible = true
	showing = true
	current = name
	count = 0
	
func _input(event):
	if event.is_action_pressed("pause") && base.state == "speaking":
		base.state = "play"
		end()
		
	if event.is_action_pressed("dialogue_next") && showing:
		if count < dialogues[current].size() && state==0:
			display(current, count)
			count += 1
		elif state == 2:
			give_berry(dialogues[current][count-1], dialogues[current][count])
			current = dialogues[current][count]
			count = 0
			display(current, count)
			count += 1
			state = 0
		else:
			base.state = "play"
			end()
			state = 0
			
func end():
		showing = false
		visible = false
		yield(get_tree().create_timer(0.1), "timeout")
		base.speaking = false
			
func give_berry(berrynum, next):
	emit_signal("giveberry", berrynum)
	emit_signal("purchased", next)
	

func display(name, num):
	if typeof(dialogues[name][num]) == TYPE_INT:
		if dialogues[name][num] == 1:
			label.bbcode_text = "[center]" + tr("NPC_GIFT_ONE").format({person = tr("NAME_FIR")}) + "[/center]"
		else:
			label.bbcode_text = "[center]" + tr("NPC_GIFT_MANY").format({number=dialogues[name][num], person=tr("NAME_FIR")}) + "[/center]"
		choice.visible = true
		if base.berries < dialogues[name][num]:
			accept.set_disabled(true)
			cancel.grab_focus()
		else:
			accept.set_disabled(false)
			accept.grab_focus()
		
	else:
		choice.visible = false
		label.bbcode_text = tr(dialogues[name][count])
	
func _on_accept_focus_entered():
	if accept.disabled:
		cancel.grab_focus()
	else:
		print('dialogue accept')
		state = 2

func _on_cancel_focus_entered():
	print('dialogue cancel')
	state = 1

