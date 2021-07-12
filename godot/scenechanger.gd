extends CanvasLayer

signal scene_changed(spawn)

onready var anim = $AnimationPlayer
onready var color = $Control/ColorRect


func change_scene(path, delay = 0.5):
	#yield(get_tree().create_timer(delay), "timeout")
	anim.play("fade")
	yield(anim, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	#emit_signal("scene_changed", spawn)
	print("scene changeed")
	print(get_tree().get_current_scene())
	yield(get_tree().get_current_scene(), "ready")
	print("ready")
	#emit_signal("scene_changed", spawn)
	print("emitted")
	yield(get_tree().get_current_scene(), "change_done")
	print("changed")
	anim.play_backwards("fade")
	yield(anim, "animation_finished")


	
	
