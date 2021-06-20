extends Node2D

onready var spawn = $spawn
onready var player = $player
onready var rope = $rope

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if spawn.on == true:
		player.global_position = spawn.global_position
		rope.global_position = player.global_position + Vector2(-19, 15)
		

	
func scene_changed(spawn):
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
