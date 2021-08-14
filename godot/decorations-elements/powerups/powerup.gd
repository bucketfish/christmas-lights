extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var a = rng.randi_range(0, 360)
	print(a)
	$Sprite.rotation_degrees = a



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
