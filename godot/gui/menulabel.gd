extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
export var key:String
export var center = true


# Called when the node enters the scene tree for the first time.
func _ready():
	bbcode_enabled = true
	if center:
		bbcode_text = "[center]%s[/center]" % [tr(key)]
	else:
		bbcode_text = tr(key)
		
func reload_lang():
	_ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
