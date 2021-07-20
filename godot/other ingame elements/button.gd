extends Node2D

export var button_input = ""
onready var anim = $AnimationPlayer

var keys = {
	"jump": "z",
	"left": "←",
	"right":"→",
	"interact":"↑",
	"down":"↓",
	"slide": "x",
	"notebook": "tab"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$z.text = keys[button_input]
	anim.play("release")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed(button_input):
		anim.play("click")
	elif Input.is_action_just_released(button_input):
		anim.play("release")

