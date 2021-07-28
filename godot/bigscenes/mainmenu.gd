extends Node2D


onready var bt_play = $CanvasLayer/Control/VBoxContainer/VBoxContainer/button
onready var bt_options = $CanvasLayer/Control/VBoxContainer/VBoxContainer/button2
onready var bt_quit = $CanvasLayer/Control/VBoxContainer/VBoxContainer/button3
onready var all = $CanvasLayer/Control
onready var version = $CanvasLayer/Control/version/version
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	all.visible = true
	bt_play.grab_focus()
	Options.connect("exit_options", self, "exit_options")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_button_pressed():
	Scenechanger.change_scene("res://bigscenes/game.tscn")


func _on_quit_pressed():
	Scenechanger.fade_to_black()
	yield(Scenechanger, "faded")
	get_tree().quit()


func _on_options_pressed():
	all.visible = false
	Options.main.visible = true
	Options.open_options()
	
func exit_options():
	all.visible = true
	bt_play.grab_focus()
