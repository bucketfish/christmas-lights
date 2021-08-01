extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var current = false
export var pageid:String
export var nodeleft:NodePath
export var noderight:NodePath

var left
var right

onready var arrowright = get_node("../../arrow_right")
onready var arrowleft = get_node("../../arrow_left")

signal focused(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	if nodeleft:
		left = get_node(nodeleft)
	if noderight:
		right = get_node(noderight)
	
	modulate.a = 0
	get_parent().get_parent().connect("getcurrent", self, "getfocus")
	connect("focused", get_parent().get_parent(), "_on_node_selected")
	
func getfocus(page):
	if page == pageid:
		emit_signal("focused", self)
		get_parent().get_tab().current = get_parent().get_tab().get_path_to(self)
		current = true
		modulate.a = 1
		if left:
			arrowleft.visible = true
		else:
			arrowleft.visible = false
		
		if right:
			arrowright.visible = true
		else:
			arrowright.visible = false
	else:
		current = false
		modulate.a = 0
		


