extends Node2D

const idle_duration = 1.0

export var speed = 5.0

onready var platform = $platform
onready var tween = $Tween
onready var p1 = $p1.position
onready var p2 = $p2.position

var follow = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	platform.position = p1
	$Line2D.add_point(p1)
	$Line2D.add_point(p2)
	_init_tween()
	
func _init_tween():
	var duration = p2.length() / float(speed * 32)
	#var duration = 5.0
	tween.interpolate_property(self, "follow", p1, p2, duration, Tween.TRANS_LINEAR, Tween.EASE_IN, idle_duration)
	tween.interpolate_property(self, "follow", p2, p1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN, duration + idle_duration * 2.0)
	tween.start()

func _physics_process(delta):
	platform.position = platform.position.linear_interpolate(follow, 0.075)
	
