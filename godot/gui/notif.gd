extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	$input_button.visible = false
	$notebook.visible = false
	$hollyberry.visible = false

func show_notif(thing):
	$input_button.visible = false
	$notebook.visible = false
	$hollyberry.visible = false
	
	$AnimationPlayer.play(thing)
	yield($AnimationPlayer, "animation_finished")
