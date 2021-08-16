extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var shadow = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if shadow:
		occluder_light_mask = 1
	else:
		var thing = CanvasItemMaterial.new()
		thing.light_mode = CanvasItemMaterial.LIGHT_MODE_UNSHADED
		self.material = thing

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
