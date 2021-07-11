extends Control

onready var labels = {
	"room_name": $HBoxContainer/textsright/room_name,
	"berries": $HBoxContainer/textsright/berries
}

# Declare member variables here. Examples:
var on = false


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func update_debug(thing, value):
	labels[thing].bbcode_text =  ("[right]" + str(value))


func _input(event):
	if event.is_action_pressed("debug"):
		on = !on
		opendebug(on)

func opendebug(val):
	visible = on
