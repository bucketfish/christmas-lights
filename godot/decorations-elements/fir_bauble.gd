extends Area2D

onready var animate = $AnimationPlayer
onready var text = $RichTextLabel

export var key = ""

var inside = false

# Called when the node enters the scene tree for the first time.
func _ready():
	text.modulate = 0
	text.bbcode_text = "[center]" + tr(key) + "[/center]"
#	workaround.text = tr(key)
#	text.rect_min_size = workaround.rect_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#print(get_overlapping_bodies())



func _on_text_area_entered(area):
	animate.play("appear")
	inside = true


func _on_text_area_exited(area):
	animate.play_backwards("appear")
	inside = false
