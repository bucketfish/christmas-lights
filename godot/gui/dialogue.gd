extends Control

onready var label = $NinePatchRect/MarginContainer/VBoxContainer/RichTextLabel
onready var choice = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer
onready var cancel = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/cancel
onready var accept = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/accept
#onready var margin = $NinePatchRect/MarginContainer/VBoxContainer/MarginContainer

onready var base = get_node("/root/game")


signal purchased(nextline)
signal give(item, count)
signal nextline
signal choice_nextline(chosen)

signal action(thing)

var showing = false
var current = ""
var count = 0

onready var line = preload("../npcs/lines.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	choice.visible = false
	$rain/name.bbcode_text = "[color=#add8ff]%s[/color]" % [tr("NAME_RAIN")]
	base.connect("change_state", self, "resume")

func show_dialogue(num):
	base.state = "dialogue"
	visible = true
	current = num
	choice.visible = false
	dialogue_loop(line.line[num])


func _input(event):

	if event.is_action_pressed("dialogue_next") && showing && choice.visible == false:
		emit_signal("nextline")



func dialogue_loop(cur):
	showing = true
	for i in cur:
		match i[0]:
			"s":
				propagate_call("check", [i[2]])
				display(i[1], i[2]) #show line i[1] with character i[2]
				yield(self, "nextline")
				#hide the head

			"a":
				if i[1] == "get_item":
					give_item(i[2], i[3])
				
					
				elif i[1] == "get_notebook":
					get_node("/root/game/notebook/notebook").collected.append(i[2])
					get_node("/root/game/notebook/notebook").update_book()
					get_node("/root/game/gui/notif").show_notif("notebook")

			"c":
				propagate_call("check", [""])
				 #do something
				if i[1] == "insert_berry":
					choice("DIALOGUE_INSERT_MANY", "DIALOGUE_INSERT", "DIALOGUE_CANCEL", i[2])
				elif i[1] == "give_berry" && i[2] == 1:
					choice("DIALOGUE_GIFT_ONE", "DIALOGUE_GIFT", "DIALOGUE_CANCEL", 1)
				elif i[1] == "give_berry":
					choice("DIALOGUE_GIFT_MANY", "DIALOGUE_GIFT", "DIALOGUE_CANCEL", i[2])
				
				yield(get_tree().create_timer(0.5), "timeout")
				
				var chosen = yield(self, "choice_nextline")

				if chosen:
					dialogue_loop(line.line[i[3]])
				else:
					dialogue_loop(line.line[i[4]])
				return

			"e":
				emit_signal("action", i[1])
				
	showing = false
	end()

func resume(thing):
	if thing == "dialogue" && choice.visible == true:
		cancel.grab_focus()
		
func end():
		showing = false
		visible = false
		yield(get_tree().create_timer(0.3), "timeout")
		base.state = "play"
		base.speaking = false

func give_item(item, number):
	#player gets item
	emit_signal("give", item, number)

func choice(text, accept_text, cancel_text, amount):
	#player gives item
	label.bbcode_text = "[center]" + tr(text).format({number = amount}) + "[/center]"
	accept.text = tr(accept_text)
	cancel.text = tr(cancel_text)
	choice.visible = true
	if base.berries < amount:
		accept.make_disabled(true)
		cancel.grab_focus()
	else:
		accept.make_disabled(false)
		accept.grab_focus()
#


func display(linename, person):
	choice.visible = false
	label.bbcode_text = tr(linename)


func _on_accept_focus_entered():
	if accept.disabled:
		cancel.grab_focus()
	else:
		print('dialogue accept')

func _on_cancel_focus_entered():
	print('dialogue cancel')

func reload_lang():
	$rain/name.bbcode_text = "[color=#add8ff]%s[/color]" % [tr("NAME_RAIN")]


func _on_cancel_pressed():
	emit_signal("choice_nextline", false)


func _on_accept_pressed():
	emit_signal("choice_nextline", true)


