extends KinematicBody2D

export var scene_id = "player"
signal anim(anim_name)

var physics = {
	"air": {
		"speed": 700,
		"gravity": 2800,
		"friction": 0.4,
		"acceleration": 0.20,
		"jumpheight": 240,
		"jumpinc": 0.74,
		"jgravity": 550,
		"downgravity": 0
	},
	"water":{
		"speed": 300,
		"gravity": 50,
		"friction": 0.2,
		"acceleration": 0.10,
		"jumpheight": 10,
		"jumpinc": 1,
		"jgravity": 100,
		"downgravity": 25
	}
}


onready var raycasts = {
	"floor": [$floor_raycast/RayCast2D, $floor_raycast/RayCast2D2, $floor_raycast/RayCast2D3],
	"stand": [$stand_raycast/RayCast2D, $stand_raycast/RayCast2D2, $stand_raycast/RayCast2D3]
}

export (int) var speed = 800
export (int) var slidespeed = 2000
export (int) var gravity = 3000
export (int) var downgravity = 0

export (float, 0, 1.0) var friction = 0.4
export (float, 0, 1.0) var acceleration = 0.20
export (float, 0, 1.0) var slideacceleration = 0.05

export (float, 0, 1.0) var jumpheight = 250
export (float, 0, 1.0) var jumpinc = 0.79
export (float, 0, 1.0) var jgravity = 600

var velocity = Vector2.ZERO
var curforce = jumpheight
var jumping = false
#var canstand = true
var pickup = false
var plant_pickup = false
var dialogue = false
var inwater = false

var giving = false

var playerpause = false
var curphy:String

var doublejump = false
var doubledash = false
var speedboost = false

var abilities = {
	"slide": false,
	"dash": false
}

var acc = []

signal berry_end

onready var animationState = $AnimationTree.get("parameters/playback")
onready var base = get_node("/root/game")

func _ready():
	$AnimationTree.active = true
	change_physics("air")
	$slide.disabled = true
	$"collision box".disabled = false
	base.connect("finish_load", self, "on_load")
	
func on_load():
	for i in acc:
		get_node(i).visible = true

func get_input(delta):
	
	if giving:
		return
		
	elif base.state != "play":
		velocity.x = 0
		animationState.travel("idle")
		return
	
	
	var dir = 0
	
	
	if Input.is_action_pressed("right"):
		dir += 1
	if Input.is_action_pressed("left"):
		dir -= 1
	
		
	if dir != 0 && animationState.get_current_node() == "slide":
		velocity.x = lerp(velocity.x, dir * slidespeed, slideacceleration * delta * 70)
	elif dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration * delta * 70)
	else:
		velocity.x = lerp(velocity.x, 0, friction * delta * 70)

	#JUMP!!!!!
	if Input.is_action_just_released("jump"):	
		if velocity.y < 0:
			velocity.y += jgravity
		jumping = false
			
	if Input.is_action_pressed("jump"):
		if inwater || raycast("floor"):
			jumping = true
		
		if inwater:
			velocity.y -= downgravity
		elif jumping:
			velocity.y = clamp(velocity.y - curforce, -1000, 10000000)
			curforce *= jumpinc
		
		
	if Input.is_action_pressed("down") && inwater:
		velocity.y += downgravity
	
	
	if raycast("floor"):
		curforce = jumpheight
		if speedboost:
			speed = physics[curphy]["speed"]
		doublejump = false
		doubledash = false
		speedboost = false
		
		
	if Input.is_action_pressed("right"):
		$Sprite.set_flip_h(false)
		$plant.scale.x = 1

	elif Input.is_action_pressed("left"):
		$Sprite.set_flip_h(true)
		$plant.scale.x = -1
		
	var onfloor = raycast("floor")
	var canstand = raycast("stand")
	


		
	if (canstand == false && animationState.get_current_node() == "slide"):
		animationState.travel("slide")
		
	elif !inwater && Input.is_action_pressed("jump") && onfloor:
		animationState.travel("jump")
	elif !inwater && animationState.get_current_node() == "fall" && onfloor:
		animationState.travel("land")
	elif !inwater && velocity.y > 0 && !onfloor:
		animationState.travel("fall")
		
	elif abilities["slide"] == true && (onfloor && Input.is_action_pressed("slide") && (Input.is_action_pressed("left")  || Input.is_action_pressed("right"))):
		animationState.travel("slide")
	elif (Input.is_action_pressed("interact") && pickup):
		animationState.travel("pickup")
	elif (Input.is_action_pressed("interact") && plant_pickup):
		animationState.travel("plant_take")
	elif (Input.is_action_pressed("left") || Input.is_action_pressed("right")) && (onfloor || inwater) && !Input.is_action_pressed("jump"):
		animationState.travel("walk") 
	elif !Input.is_action_pressed("left") && !Input.is_action_pressed("right") && !Input.is_action_pressed("jump") && (onfloor || inwater):
		animationState.travel("idle")
		
		
	if animationState.get_current_node()=="slide":
		$Sprite/fir_sled.visible = true
	else:
		$Sprite/fir_sled.visible = false

func give_berry():
	giving = true
	animationState.travel("give")

func berry_end():
	giving = false
	emit_signal("berry_end")

func _physics_process(delta):
	get_input(delta)
	velocity.y = clamp(velocity.y + gravity * delta, -1500, 1500)
	var snap = Vector2.DOWN if !jumping else Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP )
	
func gain_ability(ability):
	abilities[ability] = true

func gain_acc(thing):
	acc.append(thing)
	get_node(thing).visible = true
	
func change_physics(new):
	curphy = new
	for i in physics[new].keys():
		set(i, physics[new][i])


func raycast(area):
	for i in raycasts[area]:
		if i.is_colliding():
			return true
	return false
	
func _on_canstand_area_entered(area):
	if area.is_in_group("pickup"):
		pickup = true
	if area.is_in_group("dialogue"):
		dialogue = true
	if area.is_in_group("speed_powerup"):
		speedboost = true
		$Label.text = "A"
		speed = 1400


func _on_canstand_area_exited(area):
	if area.is_in_group("pickup"):
		pickup = false
	if area.is_in_group("dialogue"):
		dialogue = false

func _on_plant_area_area_entered(area):
	if area.is_in_group("pickup"):
		plant_pickup = true
	if area.is_in_group("dialogue"):
		dialogue = true


func _on_plant_area_area_exited(area):
	if area.is_in_group("pickup"):
		plant_pickup = false
	if area.is_in_group("dialogue"):
		dialogue = false
		

func save():
	var save_dict = {
		"abilities": abilities,
		"acc": acc
	}
	return save_dict


func _on_canstand_body_entered(body):
	if body.is_in_group("water"):
		inwater = true
		change_physics("water")
		velocity.y /= 10
		if velocity.y < 100:
			velocity.y = 100
		animationState.travel("idle") 


func _on_canstand_body_exited(body):
	if body.is_in_group("water"):
		inwater = false
		change_physics("air")
		curforce = jumpheight
		if Input.is_action_pressed("jump"):
			velocity.y = -curforce
