extends TextureButton

export(String) var text
export(String) var disabled_text
export var font_size:float = 40
export var language:String

onready var label = $label

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
	pass
	
func setup_text():
	label.bbcode_text = "[center] %s [/center]" % [text]
	
func select_text():
	label.bbcode_text = "[center][color=#add8ff] • %s • [/color][/center]" % [text]
	
func _on_button_focus_entered():
	select_text()

func _on_button_focus_exited():
	setup_text()

func _on_button_mouse_entered():
	grab_focus()


func _on_button_pressed():
	TranslationServer.set_locale(language)
	$"/root/Options".lang()
	$"/root/game".lang()
	


