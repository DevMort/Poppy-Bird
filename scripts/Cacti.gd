extends Node2D

export (bool) var prespawned_cacti

var bird
var cacti

func _ready():
	randomize()
	
	if prespawned_cacti:
		global_position.y = rand_range(474, 780)
	
	bird = get_parent().get_parent().get_node("Bird")

func _on_player_detector_body_entered(body):
	var new_cacti = get_parent().get_parent().cacti.instance()
	
	new_cacti.global_position.y = rand_range(474, 780)
	new_cacti.global_position.x = global_position.x + Global.gap
	
	get_parent().call_deferred("add_child", new_cacti)

func _on_player_exit_detector_body_entered(body):
	queue_free()

func _on_goal_body_exited(body):
	body.point_sound.play()
	Global.score += 1

func spiked(body):
	if !body.dead:
		body.pipe_sound.play()
		body.dead = true
		
		get_parent().get_parent().dead_timer.start()
		get_parent().get_parent().shake_cam = true
