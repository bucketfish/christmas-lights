extends Control

onready var label = $NinePatchRect/MarginContainer/VBoxContainer/RichTextLabel
onready var choice = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer
onready var cancel = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/cancel
onready var accept = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/accept
#onready var margin = $NinePatchRect/MarginContainer/VBoxContainer/MarginContainer

onready var base = get_node("/root/game")

signal purchased(nextline)
signal give(item, count)

var showing = false
var current = ""
var count = 0

onready var line = preload("../npcs/lines.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	choice.visible = false
	$rain/RichTextLabel.bbcode_text = "[color=#add8ff]%s[/color]" % [tr("NAME_RAIN")]

func show_dialogue(num):
	count = 0
	base.state = "dialogue"
	visible = true
	showing = true
	current = num

	
func _input(event):
	if event.is_action_pressed("pause") && base.state == "speaking":
		base.state = "play"
		end()
		
	if event.is_action_pressed("dialogue_next") && showing:
		
		if count >= line.line[current].size():
			end()
			return
			
		if count >= 1:
			if line.line[current][count-1][0] == "s" && line.line[current][count-1][2] != line.line[current][count][2]:
				get_node(line.line[current][count-1][2]).hide()
				
		
		if count < line.line[current].size():
			if line.line[current][count][0] == "s":
				display(current, count)

				get_node(line.line[current][count][2]).show()
				
				
			elif line.line[current][count][0] == "a":
				if line.line[current][count][1] == "get_item":
					#give item x in amount y
					give_item(line.line[current][count][2], line.line[current][count][3])
				count += 1
				
				if count+1 >= line.line[current].size():
					end()
			

		count += 1
			
func end():
		showing = false
		visible = false
		yield(get_tree().create_timer(0.3), "timeout")
		base.state = "play"
		base.speaking = false
			
func give_item(item, number):
	emit_signal("give", item, number)
	
func display(name, num):
#	if typeof(dialogues[name][num]) == TYPE_INT:
#		if dialogues[name][num] == 1:
#			label.bbcode_text = "[center]" + tr("NPC_GIFT_ONE").format({person = tr("NAME_FIR")}) + "[/center]"
#		else:
#			label.bbcode_text = "[center]" + tr("NPC_GIFT_MANY").format({number=dialogues[name][num], person=tr("NAME_FIR")}) + "[/center]"
#		choice.visible = true
#		if base.berries < dialogues[name][num]:
#			accept.set_disabled(true)
#			cancel.grab_focus()
#		else:
#			accept.set_disabled(false)
#			accept.grab_focus()
#
#	else:
	choice.visible = false
	label.bbcode_text = tr(line.line[current][count][1])

	
func _on_accept_focus_entered():
	if accept.disabled:
		cancel.grab_focus()
	else:
		print('dialogue accept')

func _on_cancel_focus_entered():
	print('dialogue cancel')

func reload_lang():
	$rain/RichTextLabel.bbcode_text = "[color=#add8ff]%s[/color]" % [tr("NAME_RAIN")]
