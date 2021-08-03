extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	open = false
	$gate/AnimationPlayer.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_button_press():
	if !open:
		open = true
		$gate/AnimationPlayer.play("open")
