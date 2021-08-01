extends "res://small things/item.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var itemid:String


func _on_AnimationPlayer_animation_finished(anim_name):
	get_node("/root/game").berries += 1
	get_node("/root/game/gui/notif").show_notif("berry")
	
	if itemid:
		get_node("/root/game/notebook/notebook").collected.append(itemid)
		get_node("/root/game/notebook/notebook").update_book()
		get_node("/root/game/gui/notif").show_notif("notebook")

