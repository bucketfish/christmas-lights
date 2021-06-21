extends Node2D

export var spawns: int
onready var player = $player
onready var rope = $rope

signal change_done
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#get_parent().connect("scene_changed", self, "_on_scene_change")
	pass
	
func on_scene_change(id):
	for i in range(spawns):
		var spawn = get_node("spawn" + str(i+1))
		print(id + ' | ' + spawn.id)
		if spawn.id == id:
			player.global_position = spawn.global_position
			rope.global_position = player.global_position + Vector2(-19, 15)	
	emit_signal("change_done")
			




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
