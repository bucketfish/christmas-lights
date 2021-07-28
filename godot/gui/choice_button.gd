extends TextureButton

export(String) var text
export(String) var disabled_text
export(NodePath) var parent

export var id:int
export var font_size:float = 48
export var variable:String

onready var label = $HBoxContainer/label
onready var slider = $HBoxContainer/Control/Path2D/PathFollow2D
onready var tween = $Tween

signal value_change(variable, value)

var colors = [
	"f1656c",
	"FF7F00",
	"FFEF00",
	"00F11D",
	"0079FF",
	"A800FF"
]


func _ready():
	#$HBoxContainer/Control/light.set_physics_process_internal(true)
	#$HBoxContainer/Control/light.set_process_internal(true)

	if parent:
		get_node(parent).connect("setup_slider", self, "setup_slider")
	#setup_slider()
			
	setup_text()
	set_focus_mode(true)
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://christmas lights.ttf")
	dynamic_font.size = font_size
	label.set("custom_fonts/normal_font", dynamic_font)
	#label2.set("custom_fonts/normal_font", dynamic_font)
	#$label.set("custom_fonts/normal_font/size", size)
	#$label.custom_fonts.normal_font.size = size
	
func setup_slider(nums):
	slider.unit_offset = get_node(parent).get_parent().config[variable]
	$HBoxContainer/Control/Path2D/PathFollow2D/KinematicBody2D/light.modulate = '#40' + colors[nums[id]]
	$HBoxContainer/Control/Path2D/PathFollow2D/KinematicBody2D/bulb.frame = nums[id]
	
func _process(_delta):
	#if Engine.editor_hint:
	#	select_text()
	if disabled:
		disable_text()
	
func setup_text():
	label.bbcode_text = "%s" % [tr(text)]
	$front.visible = false
	$back.visible = false
	#label2.bbcode_text = ""
	
func select_text():
	label.bbcode_text = "[color=#add8ff]%s[/color]" % [tr(text)]
	$front.visible = true
	$back.visible = true
	#label2.bbcode_text = "[center][color=#add8ff] • [/color][/center]"
	
func disable_text():
	label.bbcode_text = "[center][color=#6d6d6d] %s [/color][/center]" % [tr(disabled_text)]

func _on_button_focus_entered():
	select_text()

func _on_button_focus_exited():
	setup_text()

func _on_button_mouse_entered():
	grab_focus()


func _input(event):
	if !is_hovered():
		return
	var dir = 0
	
	if event.is_action_pressed("right"):
		dir += 1
	if event.is_action_pressed("left"):
		dir -= 1
	if dir == 0:
		return
		
	slider.unit_offset += 0.1 * dir
	emit_signal("value_change", variable, slider.unit_offset)

func reload_lang():
	setup_text()
