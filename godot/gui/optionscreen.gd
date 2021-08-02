extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export var screenname:String
export(NodePath) var initial
export(NodePath) var head

signal setup_slider(colors)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("change_screen", self, "change_screen")
	

func change_screen(name):
	if name == screenname:
		var nums = [
			0, 1, 2, 3, 4, 5
		]
		nums.shuffle()
		emit_signal("setup_slider", nums)
		propagate_call("setup_keys")
		visible = true
		get_node(initial).grab_focus()
		
	else:
		visible = false
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
