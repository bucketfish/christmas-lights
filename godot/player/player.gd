extends KinematicBody2D

export var scene_id = "player"
export (int) var speed = 800
export (int) var slidespeed = 2000
export (int) var gravity = 3000

export (float, 0, 1.0) var friction = 0.4
export (float, 0, 1.0) var acceleration = 0.20
export (float, 0, 1.0) var slideacceleration = 0.05

export (float, 0, 1.0) var jumpheight = 250
export (float, 0, 1.0) var jumpinc = 0.79
export (float, 0, 1.0) var jgravity = 600

var velocity = Vector2.ZERO
var curforce = jumpheight
var canstand = true
var pickup = false

var abilities = {
	"slide": false,
	"dash": false
}

onready var animationState = $AnimationTree.get("parameters/playback")
onready var base = get_node("/root/game")

func _ready():
	$AnimationTree.active = true
	
func get_input(delta):
	if base.speaking:
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
			
	if Input.is_action_pressed("jump"):
		velocity.y -= curforce
		curforce *= jumpinc
#
	if is_on_floor():
		curforce = jumpheight
		
		
	if Input.is_action_pressed("right"):
		$Sprite.set_flip_h(false)


	elif Input.is_action_pressed("left"):
		$Sprite.set_flip_h(true)
		
		
	

	if (canstand == false && animationState.get_current_node() == "slide"):
		animationState.travel("slide")
		
	elif Input.is_action_pressed("jump") && is_on_floor():
		animationState.travel("jump")
	elif animationState.get_current_node() == "fall" && is_on_floor():
		animationState.travel("land")
	elif velocity.y > 0 && !is_on_floor():
		animationState.travel("fall")
		
	elif abilities["slide"] == true && (is_on_floor() && Input.is_action_pressed("slide") && (Input.is_action_pressed("left")  || Input.is_action_pressed("right"))):
		animationState.travel("slide")
	elif (Input.is_action_pressed("interact") && pickup):
		animationState.travel("pickup")
	elif (Input.is_action_pressed("left") || Input.is_action_pressed("right")) && is_on_floor() && !Input.is_action_pressed("jump"):
		animationState.travel("walk") 
	elif !Input.is_action_pressed("left") && !Input.is_action_pressed("right") && !Input.is_action_pressed("jump") && is_on_floor():
		animationState.travel("idle")
		
		
	if animationState.get_current_node()=="slide":
		$Sprite/fir_sled.visible = true
	else:
		$Sprite/fir_sled.visible = false

		

func _physics_process(delta):
	get_input(delta)
	#if !is_on_floor()  || velocity.x != 0:
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	canstand = true
	for i in $canstand.get_overlapping_bodies():
		if !i.is_in_group("player"):
			canstand = false

func gain_ability(ability):
	abilities[ability] = true


func _on_canstand_area_entered(area):
	if area.is_in_group("pickup"):
		pickup = true


func _on_canstand_area_exited(area):
	if area.is_in_group("pickup"):
		pickup = false

func save():
	var save_dict = {
		"abilities": abilities
	}
	return save_dict
