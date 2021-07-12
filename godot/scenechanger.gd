extends CanvasLayer

signal scene_changed(spawn)
signal faded

onready var anim = $AnimationPlayer
onready var color = $Control/ColorRect


func change_scene(path, delay = 0.5):

	anim.play("fade")
	yield(anim, "animation_finished")
	get_tree().change_scene(path)
	#emit_signal("scene_changed", spawn)
	print("scene changeed")
	print(get_tree().get_current_scene())
	
	print("big scene changed")
	
	yield(get_tree().create_timer(delay), "timeout")
	anim.play_backwards("fade")
	yield(anim, "animation_finished")


func fade_to_black():
	anim.play("fade")
	yield(anim, "animation_finished")
	emit_signal("faded")

	
	
