extends Node2D

#signal scene_changed(spawn)

onready var changeanim = $scenechanger/AnimationPlayer
onready var berrylabel = $gui/berry/berrylabel
onready var dialogue = $gui/dialogue
onready var camera = $camera
onready var player = $player
onready var debug = $gui/debug


export var testscene: String
export var testspawn: String

export var scene_id = "base"


var scenes = {"base":{}}

var npc_dialogue = {}

var berries = 0 setget berry_set
var speaking = false setget speaking_set
var curscene = ""
var lastspawn = "" 

signal dialogue_start
signal dialogue_end
signal finish_save
signal finish_load
# Called when the node enters the scene tree for the first time.


func _ready():
	scenes["base"] = {
		"berries": berries,
		"curscene": curscene,
		"lastspawn": lastspawn,
		"npc_dialogue": npc_dialogue,
	}
	
	if testscene && testspawn:
		change_scene(testscene, testspawn)
	elif not File.new().file_exists("user://saves.save"):
		change_scene("res://rooms/white/white-1.tscn", "intro_start")
	else:
		load_game()
		#yield(self, "finish_load")
		berry_set(berries)
		print(curscene + " " + lastspawn)
		if curscene != "" && lastspawn != "":
			change_scene(curscene, lastspawn)
		
		#change_scene("res://rooms/intro.tscn", "intro_start")

func change_scene(path, towards):
	changeanim.play("fade")
	yield(changeanim, "animation_finished")
	curscene = path
	lastspawn = towards
	scenes['base']['curscene'] = curscene
	scenes['base']['lastspawn'] = lastspawn
	save_game()
	for i in get_children():
		if i.is_in_group("room"):
			i.queue_free()
	var newroom = load(path).instance()
	call_deferred("add_child", newroom)
	newroom.call_deferred("on_scene_change", towards)
	yield(newroom, "change_done")
	load_game()
	#if !(newroom.scene_id in scenes):
	#	scenes.append(newroom.scene_id)
	yield(get_tree().create_timer(0.3), "timeout")
	changeanim.play_backwards("fade")	
	

func save_game():
	#prepares the file
	var saves = File.new()
	saves.open("user://saves.save", File.WRITE)
	
	#save game node stuff

	
	var save_nodes = get_tree().get_nodes_in_group("save")	
	#var save_nodes = []
	for node in save_nodes:

		 # Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
	
		# Call the node's save function.
		scenes[node.scene_id] = node.call("save")

		 # Store the save dictionary as a new line in the save file.
	saves.store_line(to_json(scenes))
	print("game saved! " + str(scenes))
	
	saves.close()
	emit_signal("finish_save")



func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://saves.save"):
		return # Error! We don't have a save to load.

	var save_nodes = get_tree().get_nodes_in_group("save")

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://saves.save", File.READ)

	# Get the saved dictionary from the next line in the save file
	var node_data = parse_json(save_game.get_line())
	
	for i in node_data.keys():
		# Firstly, we need to create the object and add it to the tree and set its position.
		for j in node_data[i].keys():
			if !(i in scenes.keys()):
				scenes[i] = {}
			scenes[i][j] = node_data[i][j]
						
		if i == "base":
			for j in node_data[i].keys():
				set(j, node_data[i][j])
				#scenes[i][j] = node_data[i][j]
				if j == "npc_dialogue":
					update_npc_dialogue()
				#if j == "berries":
					#berry_set(node_data[i][j])
			continue
		for j in save_nodes:
			if j.scene_id == i:
				for k in node_data[i].keys():
					if typeof(node_data[i][k]) == TYPE_ARRAY:
						j.set(k, node_data[i][k].duplicate())
					else:
						j.set(k, node_data[i][k])
					
				break
				

	save_game.close()
	print("loaded! " + str(scenes))
	emit_signal("finish_load")




func update_npc_dialogue():
	print("update npc dialogue")
	for i in get_tree().get_nodes_in_group("npc"):
		if i.npcname in npc_dialogue.keys():
			i.dialoguenum = npc_dialogue[i.npcname]
	
	

func berry_set(value):
	berrylabel.text = str(value)
	print("berry count changed from " + str(berries) + " to " + str(value))
	berries = value
	scenes['base']['berries'] = value
	
func dialogue_set(value):
	dialogue.show_dialogue(value)
	speaking_set(true)

func speaking_set(value):
	speaking = value
	if speaking == true:
		emit_signal("dialogue_start")
		print("dialogue start")
	else:
		emit_signal("dialogue_end")
		print('dialogue end')


func _on_dialogue_giveberry(count):
	berry_set(berries - count)

func gain_ability(ability):
	player.gain_ability(ability)
	
func update_debug(item, value):
	debug.update_debug(item, value)

