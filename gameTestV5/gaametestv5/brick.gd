extends CharacterBody2D

class_name Paddle

var speed = 2000

func _ready() -> void:
	print("ON REAADY")

func _process(delta: float) -> void:
	if Input.is_action_pressed("down"):
		velocity = Vector2(0, 1) * speed
		move_and_slide()
	if Input.is_action_pressed("up"):
		velocity = Vector2(0, -1) * speed 
		move_and_slide()
