extends Position2D


export var on: bool
export var towards: String
export var id: String
export var path: String
var enabled = true

func _ready():
	if on:
		enabled = false


func _on_Area2D_area_entered(area):
	if enabled:
		Scenechanger.change_scene(path, towards)


func _on_Area2D_area_exited(area):
	enabled = true

