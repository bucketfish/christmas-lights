extends Node2D

onready var text = $text
export var number:float
onready var base = get_node("/root/game")

signal remove_berry(id)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.position.y = 0
	base.connect("finish_load", self, "_on_finish_load")
	
func _on_finish_load():
	#print("A it works " + str(self))
	#print(str(number) + " " + str(get_parent().berries))
	if !(number in get_parent().berries):
		queue_free()


func _input(event):
	if event.is_action_pressed("interact") && text.inside == true:
		$AnimationPlayer.play("pickup")
		yield($AnimationPlayer, "animation_finished")
		get_node("/root/game").berries += 1
		emit_signal("remove_berry", number)
		queue_free()
