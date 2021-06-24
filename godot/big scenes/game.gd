extends Node2D

#signal scene_changed(spawn)

onready var changeanim = $scenechanger/AnimationPlayer
onready var berrylabel = $gui/berry/berrylabel
onready var dialogue = $gui/dialogue
onready var player = $scene/player

export var testscene: String
export var testspawn: String

var berries = 0 setget berry_set
var speaking = false setget speaking_set


signal dialogue_start
signal dialogue_end
# Called when the node enters the scene tree for the first time.
func _ready():
	if testscene && testspawn:
		change_scene(testscene, testspawn)
	else:
		change_scene("res://rooms/intro.tscn", "intro_start")

func change_scene(path, towards):
	changeanim.play("fade")
	for i in get_children():
		if i.is_in_group("room"):
			i.queue_free()
	var newroom = load(path).instance()
	call_deferred("add_child", newroom)
	#yield(newroom, "ready")
	newroom.call_deferred("on_scene_change", towards)
	yield(newroom, "change_done")
	changeanim.play_backwards("fade")	
	player = get_node("scene/player")

func berry_set(value):
	berrylabel.text = str(value)
	print("berry value changed from " + str(berries) + " to " + str(value))
	berries = value
	
func dialogue_set(value):
	dialogue.show_dialogue(value)
	speaking_set(true)

func speaking_set(value):
	speaking = value
	if speaking == true:
		emit_signal("dialogue_start")
		print("dialogue start")
	else:
		emit_signal("dialogue_end")
		print('dialogue end')


func _on_dialogue_giveberry(count):
	berry_set(berries - count)

func gain_ability(ability):
	player.gain_ability(ability)
