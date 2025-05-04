extends Area2D

var speed = 5
var velocity = Vector2()

func _physics_process(delta):
	translate(velocity)

func set_move(dir: Vector2):
	velocity = speed * dir


func _on_timer_timeout():
	queue_free()
