extends Node2D


# Declare member variables here. Examples:
# var a = 2
export(NodePath) var tab


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_tab():
	return get_node(tab)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
