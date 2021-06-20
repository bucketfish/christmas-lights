extends Node2D

onready var spawn = $spawn
onready var player = $player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if spawn.on == true:
		player.position = spawn.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
