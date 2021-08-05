extends "res://npcs/npc.gd"


# Called when the node enters the scene tree for the first time.


func _ready():
	dialogues = ["silver_intro", "silver_intro_repeat1", "silver_intro_repeat2"]
	dialogue_inc = [0, 1]
	#base.get_node("gui/dialogue").connect("purchased", self, "_on_nextline")


func dialogue_event(thing):
	if thing == "silver_give1":
		$AnimationPlayer.play("swing")
		yield($AnimationPlayer, "animation_finished")
		$AnimationPlayer.play("idle")

