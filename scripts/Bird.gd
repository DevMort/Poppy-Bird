extends KinematicBody2D

export (float) var jump_speed
export (float) var gravity_accelerator

var velocity: Vector2 = Vector2(0, 0)
var can_jump: bool = true
var dead: bool = false

onready var jump_sound = $jump
onready var anim_sprite = $AnimatedSprite
onready var pipe_sound = $pipe_collide
onready var point_sound = $point

func _physics_process(delta):
	if Input.is_action_just_pressed("space") && !dead:
		velocity.y = -jump_speed
		rotation_degrees = -45
		anim_sprite.play("jump")
		jump_sound.play()
	elif dead:
		Global.speed = 0
		anim_sprite.play("dead")
	 
	velocity.x = Global.speed
	velocity.y += gravity_accelerator
	clamp(velocity.y, -jump_speed, jump_speed)
	
	rotation_degrees = lerp(rotation_degrees, 45, 0.045)
	
	move_and_collide(velocity * delta)
	
	if !dead && (global_position.y >= 657 || global_position.y <= -136):
		pipe_sound.play()
		dead = true
		
		get_parent().dead_timer.start()
		get_parent().shake_cam = true

func _on_AnimatedSprite_animation_finished():
	anim_sprite.play("default")
