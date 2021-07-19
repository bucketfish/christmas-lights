extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var scene_id = "notebook"

onready var pages = {
	"doodles": [$doodles/doodle1, $doodles/doodle2],
	"maps": [$maps/map1, $maps/map2]
}


onready var base = get_node("/root/game")
onready var collected = ["doodle1_1"]

signal getcurrent(page)
signal checkitem
onready var current = null

var showing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	showing = false
	modulate.a = 0


func update_book():
	emit_signal("checkitem")
	print("book update")
	
func _input(event):
		
	if event.is_action_pressed("notebook"):
		showing = !showing
		get_tree().paused = showing
		
		if showing:
			base.state = "notebook"
			$animate.play("show")
			update_book()
			yield($animate, "animation_finished")
			$doodles_tab.grab_focus()
			print("doodles focus")

		else:
			base.state = "play"
			end()
			
	if base.state != "notebook":
		return
		
	if event.is_action_pressed("pause") && base.state == "notebook":
		showing = false
		base.state = "play"
		end()
		
		
	if event.is_action_pressed("ui_left"):
		if current.left:
			emit_signal("getcurrent", current.left.pageid)
	elif event.is_action_pressed("ui_right"):
		if current.right:
			emit_signal("getcurrent", current.right.pageid)
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_node_selected(nodeS):
	current = nodeS

func end():
	$animate.play("hide")
	#visible = false
	showing = false
	base.state = "play"
	get_tree().paused = false
	

		


func showitem(item):
	for i in get_tree().get_nodes_in_group("pageitem"):
		if i.itemid == item:
			i.visible = true
			return

func save():
	var stuff = {
		"collected": collected
	}
	return stuff
