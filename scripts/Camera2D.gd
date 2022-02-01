extends Camera2D

onready var bird = get_parent().get_node("Bird")

func _physics_process(delta):
	if !bird.dead:
		position.x += Global.speed * delta
