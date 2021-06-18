extends Area2D


onready var text = $RichTextLabel
onready var animate = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
#func _ready():


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#print(get_overlapping_bodies())


func _on_fir_bauble_area_entered(area):
	animate.play("appear")


func _on_fir_bauble_area_exited(area):
	animate.play_backwards("appear")
