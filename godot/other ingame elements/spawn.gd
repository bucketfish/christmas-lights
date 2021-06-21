extends Position2D


export var on: bool
export var towards: String
export var id: String
export var path: String
var enabled = true

func _ready():
	pass


func _on_Area2D_area_entered(area):
	if enabled:
		get_owner().get_parent().change_scene(path, towards)

