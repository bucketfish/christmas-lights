extends Area2D

onready var animate = $AnimationPlayer
onready var text = $RichTextLabel
onready var base = get_node("/root/game")

export var key = ""

var inside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	text.modulate = 0
	text.bbcode_text = "[center]" + tr(key) + "[/center]"
	base.connect("dialogue_start", self, "_on_dialogue_start")
	base.connect("dialogue_end", self, "_on_dialogue_end")

	

func _on_text_body_entered(body):
	if body.is_in_group("player"):
		animate.play("appear")
		inside = true


func _on_text_body_exited(body):
	if body.is_in_group("player"):
		animate.play_backwards("appear")
		inside = false

func _on_dialogue_start():
	animate.play_backwards("appear")

func _on_dialogue_end():
	animate.play("appear")
