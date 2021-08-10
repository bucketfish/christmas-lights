extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false



func _on_player_anim(anim_name):
	$AnimationPlayer.play(anim_name)

func _set(prop, val):
	if prop == "visible":
		visible = val
		$Area2D/CollisionShape2D.disabled = !val
