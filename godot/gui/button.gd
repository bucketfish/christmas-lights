extends TextureButton

export(String) var text
export(String) var disabled_text
export var font_size:float = 48

onready var label = $label

var selected = false

func _ready():
	setup_text()
	set_focus_mode(true)
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://christmas lights.ttf")
	dynamic_font.size = font_size
	$label.set("custom_fonts/normal_font", dynamic_font)
	
func _process(_delta):
	#if Engine.editor_hint:
	#	select_text()
	if disabled:
		disable_text()
	
func setup_text():
	label.bbcode_text = "[center] %s [/center]" % [tr(text)]
	
func select_text():
	label.bbcode_text = "[center][color=#add8ff] • %s • [/color][/center]" % [tr(text)]
	
func disable_text():
	label.bbcode_text = "[center][color=#6d6d6d] %s [/color][/center]" % [tr(disabled_text)]

func _on_button_focus_entered():
	selected = true
	select_text()

func _on_button_focus_exited():
	selected = false
	setup_text()

func _on_button_mouse_entered():
	grab_focus()


func reload_lang():
	if selected:
		select_text()
	else:
		setup_text()


