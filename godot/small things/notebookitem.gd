extends "res://small things/item.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var itemid:String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	get_node("/root/game/gui/notebook").collected.append(itemid)
	get_node("/root/game/gui/notebook").update_book()
