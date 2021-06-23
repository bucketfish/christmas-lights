extends Position2D


export var activate: bool = false
export var towards: String
export var id: String
export var path: String
var checking = false

func _ready():
	pass


func _on_Area2D_area_entered(area):
	if !activate:
		get_owner().get_parent().change_scene(path, towards)
	else:
		checking = true
		
func _input(event):
	if activate && checking && event.is_action_pressed("interact"):
		get_owner().get_parent().change_scene(path, towards)

func _on_Area2D_area_exited(area):
	checking = false
