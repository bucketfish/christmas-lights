extends TextureButton

export(String) var text
export(String) var key
var font_size = 32

onready var label = $HBoxContainer/Control2/label
onready var input = $HBoxContainer/Control/key

func _ready():
	setup_text()
	set_focus_mode(true)
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://christmas lights.ttf")
	dynamic_font.size = font_size
	if label.get_line_count() == 1:
		label.margin_top = 15
	
	#label.set("custom_fonts/normal_font", dynamic_font)
	#input.set("custom_fonts/normal_font", dynamic_font)
	#$front.set("custom_fonts/normal_font", dynamic_font)
	#$back.set("custom_fonts/normal_font", dynamic_font)
	
func _process(_delta):
	#if Engine.editor_hint:
	#	select_text()
	pass
	
func setup_text():
	var thing = {
		"Left": "←",
		"Right":"→",
		"Up":"↑",
		"Down":"↓",
	}
	var map = InputMap.get_action_list(key)[0].as_text()
	print(map)
	print(thing)
	if map in thing.keys():
		map = thing[map]
		
	label.bbcode_text = "%s" % [tr(text)]
	input.bbcode_text = "[right]%s" % [map]
	$front.visible = false
	$back.visible = false

	
	
func select_text():
	var thing = {
		"Left": "←",
		"Right":"→",
		"Up":"↑",
		"Down":"↓",
	}
	var map = InputMap.get_action_list(key)[0].as_text()
	if map in thing.keys():
		map = thing[map]
		
	label.bbcode_text = "[color=#add8ff]%s[/color]" % [tr(text)]
	input.bbcode_text = "[color=#add8ff][right]%s" % [map]
	$front.visible = true
	$back.visible = true
	
func _on_button_focus_entered():
	select_text()

func _on_button_focus_exited():
	setup_text()

func _on_button_mouse_entered():
	grab_focus()


func _on_button_pressed():
	pass # Replace with function body.
