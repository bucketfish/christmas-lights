extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("appear")
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	$Sprite.rotation_degrees = rng.randi_range(0, 360)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		anim.play("disappear")
		yield(get_tree().create_timer(2), "timeout")
		anim.play("appear")
