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
	choice.visible = false
	progress_dialogue()

	
func _input(event):
	if event.is_action_pressed("pause") && base.state == "speaking":
		base.state = "play"
		end()
		
	if event.is_action_pressed("dialogue_next") && showing && choice.visible == false:
		
		progress_dialogue()
		count += 1

func progress_dialogue():
	if count >= 1 && count <= line.line[current].size():
		if line.line[current][count-1][0] == "s":
			get_node(line.line[current][count-1][2]).hide()
				
	if count >= line.line[current].size():
		end()
		return
			
			
	if count < line.line[current].size():
		dialogue_logic(line.line[current][count])
		
	
func dialogue_logic(lines):
	print(lines)
	if lines[0] == "s":
		display(current, count)

		get_node(lines[2]).show()
			
		
	elif lines[0] == "a":
		count += 1
		if lines[1] == "get_item":
			#give item x in amount y
			give_item(lines[2],lines[3])
			
		elif lines[1] == "get_notebook":
			get_node("/root/game/notebook/notebook").collected.append(lines[2])
			get_node("/root/game/notebook/notebook").update_book()
			get_node("/root/game/gui/notif").show_notif("notebook")
		
		print(count)
		if count+1 >= line.line[current].size():
			end()

					
	elif lines[0] == "c":
		if lines[1] == "insert_berry":
			insert_berry(lines[2])
			
			
	
func end():
		showing = false
		visible = false
		yield(get_tree().create_timer(0.3), "timeout")
		base.state = "play"
		base.speaking = false
			
func give_item(item, number):
	#player gets item
	emit_signal("give", item, number)
	
func insert_berry(amount):
	#player gives item
	label.bbcode_text = "[center]" + tr("DIALOGUE_INSERT_MANY").format({number = amount}) + "[/center]"
	accept.text = tr("DIALOGUE_INSERT")
	choice.visible = true
	if base.berries < amount:
		accept.set_disabled(true)
		cancel.grab_focus()
	else:
		accept.set_disabled(false)
		accept.grab_focus()
#
	
	
func display(name, num):

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


func _on_cancel_pressed():
	show_dialogue(line.line[current][count-1][4])


func _on_accept_pressed():
	if line.line[current][count-1][0] == "c":
		if line.line[current][count-1][1] == "insert_berry":
			emit_signal("give", "berry", -1 * line.line[current][count-1][2])
		
	
	show_dialogue(line.line[current][count-1][3])
		
		
	#progress_dialogue()
