extends Node2D


onready var bt_play = $CanvasLayer/Control/VBoxContainer/VBoxContainer/button
onready var bt_options = $CanvasLayer/Control/VBoxContainer/VBoxContainer/button2
onready var bt_quit = $CanvasLayer/Control/VBoxContainer/VBoxContainer/button3

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	bt_play.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_button_pressed():
	Scenechanger.change_scene("res://bigscenes/game.tscn")


func _on_quit_pressed():
	Scenechanger.fade_to_black()
	yield(Scenechanger, "faded")
	get_tree().quit()
