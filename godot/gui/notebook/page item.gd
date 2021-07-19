extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var itemid:String
onready var base = get_node("/root/game")
onready var notebook = get_node("/root/game/gui/notebook")


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	base.connect("ready", self, "checkload")
	notebook.connect("checkitem", self, "checkload")

func checkload():
	visible = (itemid in notebook.collected)
	#if !(number in get_parent().item):
	#	queue_free()
