extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var scene_id:String

var open = false

onready var base = get_node("/root/game")

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(base, "finish_load")
	if open:
		$gate/AnimationPlayer.play("open")
	else:
		$gate/AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_button_press():
	if !open:
		open = true
		$gate/AnimationPlayer.play("open")

func save():
	var save_d = {
		"open": open
	}
	return save_d
