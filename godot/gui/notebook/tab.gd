extends TextureButton

export(NodePath) var childgrab
export var tabname:String
export(NodePath) var current

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0
	if childgrab:
		get_node(childgrab).visible = false



func _on_tab_focus_entered():
	$animate.play("show")
	if childgrab:
		get_node(childgrab).visible = true
		get_parent().emit_signal("getcurrent", get_node(current).pageid)
		


func _on_tab_focus_exited():
	$animate.play_backwards("show")
	if childgrab:
		get_node(childgrab).visible = false
