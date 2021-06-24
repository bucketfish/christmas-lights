extends Node

onready var camera = get_node("/root/game/camera")
onready var topleft = $topleft
onready var bottomright = $bottomright

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	camera.limit_top = topleft.position.y
	camera.limit_left = topleft.position.x
	camera.limit_bottom = bottomright.position.y
	camera.limit_right = bottomright.position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
