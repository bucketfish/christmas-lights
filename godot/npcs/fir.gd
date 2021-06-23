extends Node2D

var inrange = false

onready var base = get_node("/root/game")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		inrange = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		inrange = false
		
func _input(event):
	if inrange && event.is_action_pressed("interact"):
		base.dialogue_set("fir_intro")
