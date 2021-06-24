extends TextureButton

export(String) var text
export(String) var disabled_text

onready var label = $label

func _ready():
	setup_text()
	set_focus_mode(true)
	
func _process(delta):
	#if Engine.editor_hint:
	#	select_text()
	if disabled:
		disabled_text()
	
func setup_text():
	label.bbcode_text = "[center] %s [/center]" % [tr(text)]
	
func select_text():
	label.bbcode_text = "[center][color=#add8ff] • %s • [/color][/center]" % [tr(text)]
	
func disabled_text():
	label.bbcode_text = "[center][color=#6d6d6d] %s [/color][/center]" % [tr(disabled_text)]

func _on_button_focus_entered():
	select_text()

func _on_button_focus_exited():
	setup_text()

func _on_button_mouse_entered():
	grab_focus()
