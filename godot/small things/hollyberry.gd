extends Node2D

onready var text = $text
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.visible = true
	$Sprite.position.y = 0

func _input(event):
	if event.is_action_pressed("interact") && text.inside:
		$AnimationPlayer.play("pickup")
		yield($AnimationPlayer, "animation_finished")
		get_node("/root/game").berries += 1
		queue_free()
