extends Node2D

export (PackedScene) var cacti

onready var score_text = $"CanvasLayer/Control/MarginContainer/CenterContainer/Score Text"
onready var speed_timer = $"speed timer"
onready var menu = $CanvasLayer/Menu
onready var camera = $Camera2D
onready var dead_timer = $"dead timer"

var shake_cam: bool = false

func _ready():
	speed_timer.wait_time = 1
	
	$Bird.dead = true
	$Bird.set_physics_process(false)

func _process(delta):
	if $Bird.dead:
		speed_timer.stop()
		
	if shake_cam:
		camera.set_offset(Vector2( \
		rand_range(-1.0, 1.0) * 2.5, \
		rand_range(-1.0, 1.0) * 2.5 \
	))
	
	score_text.bbcode_text = "[center]" + String(Global.score)
	
	if Input.is_action_just_pressed("q"):
		get_tree().quit()

func _on_speed_timer_timeout():
	Global.speed += 15
	Global.gap += 15

func _on_dead_timer_timeout():
	$CanvasLayer/reminder.hide()
	shake_cam = false
	
	get_tree().reload_current_scene()

func _on_Play_pressed():
	$CanvasLayer/reminder.show()
	
	menu.hide()
	Global.score = 0
	Global.speed = 100
	Global.gap = 400
	
	$Bird.show()
	$Bird.set_physics_process(true)
	$"Cacti Parent".show()
	camera.show()
	
	speed_timer.start()
	$Bird.dead = false
