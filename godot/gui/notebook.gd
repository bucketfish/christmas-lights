extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var pages = {
	"doodles": [$doodles/doodle1, $doodles/doodle2],
	"maps": [$maps/map1, $maps/map2]
}


signal getcurrent(page)
onready var current = null

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("notebook"):
		visible = !visible
		get_tree().paused = visible
		
		if visible:
			$map_tab.grab_focus()
			#emit_signal("getcurrent", "doodle1")
			#current = $doodles/doodle1
			
	if !visible:
		return
		
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
