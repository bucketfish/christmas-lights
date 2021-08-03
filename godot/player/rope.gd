extends Node2D

var link = preload("res://player/link.tscn")
var light = preload("res://player/light.tscn")


export (int) var pieces = 20

var count = 0

var colors = [
	"f1656c",
	"FF7F00",
	"FFEF00",
	"00F11D",
	"0079FF",
	"A800FF"
]

func _ready():
	count = 0
	var parent = $PinJoint2D/link
	for _i in range (pieces):
		parent = addPiece(parent)
	lastPiece(parent)
		
func addPiece(parent):
	var joint = parent.get_node("PinJoint2D")
	var piece = link.instance()
	piece.friction = 0
	piece.position = Vector2(-140, 0)
	
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	
	var add = light.instance()
	add.get_node("Sprite").frame = count%6
	add.get_node("Light2D").color = '#' + colors[count%6]
	add.get_node("Sprite2").modulate = '#40' + colors[count%6]
	add.get_node("PinJoint2D").node_b = piece.get_path()
	piece.add_child(add)

	count += 1
	
	return piece
	
func lastPiece(parent):
	var joint = parent.get_node("PinJoint2D")
	var piece = get_parent().get_node("player/StaticBody2D")
	#make the thing teleport to piece, connct, thene teleport away
	#piece.set_position(global_position)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	#piece.set_position(Vector2(-400, 0))
