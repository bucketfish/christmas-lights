extends Node2D

var inrange = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		inrange = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		inrange = false
		
func _input(event):
	if inrange && event.is_action_pressed("interact"):
		get_node("/root/game").dialogue.show_dialogue("fir_aftersled")
