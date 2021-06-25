extends Node2D

export var spawns: int
export var scene_id = ""
onready var player = get_node("/root/game/player")
onready var rope = get_node("/root/game/rope")
onready var camera = get_node("/root/game/camera")
onready var base = get_node("/root/game")

export var totalberries = 0
var berries = [] setget set_berries

signal change_done

var lastspawn = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	berries = []
	for i in range(totalberries):
		berries.append(i+1)
		get_node("hollyberry" + str(i+1)).connect("remove_berry", self, "remove_berry")
	
	print("scene load: berry list " + str(berries))
	
func remove_berry(id):
	print("berry id " + str(id) + " picked up and gone! " + str(berries))
	berries.remove(berries.find(id))
	berries.erase(id)
	print("berries left: " + str(berries))
	
func set_berries(val):
	var new = []
	for i in berries:
		if !(i in val):
			get_node("hollyberry" + str(i)).queue_free()
		else:
			new.append(i)
	berries = new
	print("save/load new berry counts: " + str(val) + " on scene " + scene_id)
	
func on_scene_change(id):
	for i in range(spawns):
		var spawn = get_node("spawn" + str(i+1))
		if spawn.id == id:
			print(id + ' -> ' + spawn.id)
			player.global_position = spawn.global_position
			rope.global_position = player.global_position + Vector2(-19, 15)
			#camera.global_position = player.global_position	
		lastspawn = id
	emit_signal("change_done")
			

func save():
	var save_dict = {
		"lastspawn": lastspawn,
		"berries": berries
	}
	return save_dict


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
