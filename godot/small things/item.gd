extends Node2D

onready var text = $text
export var number:float
onready var base = get_node("/root/game")

signal remove_item(id)

func _ready():
	$Sprite.position.y = 0
	base.connect("finish_load", self, "_on_finish_load")

func _on_finish_load():
	if !(number in get_parent().item):
		queue_free()

func _input(event):
	if event.is_action_pressed("interact") && (text.inside == true || text.inside_plant == true):
		$AnimationPlayer.play("pickup")
		yield($AnimationPlayer, "animation_finished")
		emit_signal("remove_item", number)
		queue_free()
