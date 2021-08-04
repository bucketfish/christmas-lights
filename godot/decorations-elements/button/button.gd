extends Node2D


var pressed = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal button_press

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Area2D_body_entered(body):
	if body.is_in_group("player") && !pressed:
		emit_signal("button_press")
		$AnimationPlayer.play("press")
		pressed = true

