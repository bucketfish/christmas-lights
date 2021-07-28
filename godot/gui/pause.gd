extends Control

var paused = false

onready var bt_continue = $VBoxContainer/VBoxContainer/button
onready var bt_options = $VBoxContainer/VBoxContainer/button2
onready var bt_quit = $VBoxContainer/VBoxContainer/button3

onready var base = get_node("/root/game")
onready var notebook = get_node("/root/game/notebook/notebook")

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	Options.connect("exit_options", self, "exit_options")


func _input(event):
	if event.is_action_pressed("pause") && base.state in ["play", "dialogue"]:
		pause()
	elif event.is_action_pressed("pause") && visible == true && Options.open == false:
		base.state = "play"
		visible = !visible
		_on_continue_pressed()
	
func exit_options():
	$VBoxContainer.visible = true
	openmenu()
		
func pause():
	base.state = "paused"
	visible = !visible
	openmenu()
		
func openmenu():
	if paused:
		get_parent().pause_mode = Node.PAUSE_MODE_STOP
	else:
		get_parent().pause_mode = Node.PAUSE_MODE_PROCESS
	notebook.visible = false
	get_tree().paused = visible
	bt_continue.grab_focus()


func _on_continue_pressed():
	visible = false
	get_tree().paused = false
	base.state = "play"


func _on_quit_pressed():
	get_tree().paused = false
	base.save_game()
	Scenechanger.change_scene("res://bigscenes/mainmenu.tscn")


func _on_options_pressed():
	$VBoxContainer.visible = false
	Options.open_options()

