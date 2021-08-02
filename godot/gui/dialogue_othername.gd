extends Sprite


export var npcname:String


# Called when the node enters the scene tree for the first time.
func _ready():
	$name.bbcode_enabled = true
	$name.bbcode_text = "[right][color=#add8ff]%s[/color]" % [tr(npcname)]

func check(name):
	print(name + " " + npcname)
	if name == npcname:
		visible = true
	else:
		visible = false

func reload_lang():
	$name.bbcode_text = "[right][color=#add8ff]%s[/color]" % [tr(npcname)]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
