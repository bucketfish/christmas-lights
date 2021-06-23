extends Node2D

#signal scene_changed(spawn)

onready var changeanim = $scenechanger/AnimationPlayer
onready var berrylabel = $gui/berry/berrylabel
onready var dialogue = $gui/dialogue

export var testscene: String
export var testspawn: String

var berries = 0 setget berry_set
var speaking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if testscene && testspawn:
		change_scene(testscene, testspawn)

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

func berry_set(value):
	berrylabel.text = str(value)
	berries = value
	print("picked up berry")
	
func dialogue_set(value):
	dialogue.show_dialogue(value)
	speaking = true

