extends Node2D

var link = preload("res://player/link.tscn")
var light = preload("res://player/light.tscn")

export (int) var pieces = 24
signal teleport

var lastpiece
var lastpiecepin
var ready = false
var count = 0

func _ready():
	count = 0
	var parent = $PinJoint2D/link
	for i in range (pieces):
		parent = addPiece(parent)
	lastpiece = lastPiece(parent)
	emit_signal("teleport", Vector2(-200, 0))
	ready = true
		
func addPiece(parent):
	var joint = parent.get_node("PinJoint2D")
	var piece = link.instance()
	piece.friction = 0
	piece.position = Vector2(-70, 0)
	
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	
	if count%2==0:
		var add = light.instance()
		add.get_node("Sprite").frame = (count%12)/2
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
	return parent
#
#func _physics_process(delta):
#	if is_instance_valid(lastpiece.get_node("PinJoint2D")) && ready:
#		var diffx = get_node(lastpiece.get_node("PinJoint2D").node_a).global_position - get_parent().get_node("player/StaticBody2D").global_position
#		var diff = diffx.x
#		print(diff)
#		if diff > 40:
#			lastpiece.get_node("PinJoint2D").softness = 0
#			lastpiece = addPiece(lastpiece)
#			lastpiece=lastPiece(lastpiece)
#		elif diff < 0:
#			var new = lastpiece.get_parent().get_parent()
#			print(new)
#			lastpiece.queue_free()
#			lastpiece = lastPiece(new)
#

