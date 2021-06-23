extends Position2D


export var activate: bool = false
export var towards: String
export var id: String
export var path: String
var checking = false

func _ready():
	checking = false


func _input(event):
	if activate && checking && event.is_action_pressed("interact"):
		get_owner().get_parent().change_scene(path, towards)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if activate == false:
			get_owner().get_parent().change_scene(path, towards)
		else:
			checking = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		checking = false
