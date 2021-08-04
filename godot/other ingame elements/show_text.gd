extends Area2D

onready var animate = $AnimationPlayer
onready var text = $RichTextLabel
onready var base = get_node("/root/game")

export var key = ""
export var reshow = false

var inside = false
var using = true
var enabled = true
export var reappear = true


# Called when the node enters the scene tree for the first time.
func _ready():
	text.modulate = 0
	$CollisionShape2D.disabled = !enabled
	text.bbcode_text = "[center]" + tr(key) + "[/center]"
	base.connect("dialogue_start", self, "_on_dialogue_start")
	base.connect("dialogue_end", self, "_on_dialogue_end")

	

func _on_text_body_entered(body):
	if body.is_in_group("player") && using:
		animate.play("appear")
		inside = true


func _on_text_body_exited(body):
	if body.is_in_group("player") && using:
		animate.play_backwards("appear")
		inside = false

func _on_dialogue_start():
	print("HUH? " + str(inside) + " " + str(reappear))
	if inside && reappear:
		animate.play_backwards("appear")
		using = false

func _on_dialogue_end():
	if inside && reappear:
		animate.play("appear")
		using = true
	if !reappear:
		$CollisionShape2D.disabled = true
		
	
func reload_lang():
	text.bbcode_text = "[center]" + tr(key) + "[/center]"
