extends CharacterBody2D


const SPEED = 30.0

var starting_pos: Vector2;

@export var target_position: Vector2 = Vector2(position)

signal where_next;

var direction: Vector2

func _ready():
	starting_pos = position


func _process(delta):
	change_direction()
	 
	

func change_direction():
	if position.distance_to(target_position) > 1:
		direction = (target_position - position).normalized()
		#print(target_position, ' vs position ', position)
		#print(direction)
		velocity = direction * 60#* SPEED
		#print(velocity)
		move_and_slide()
		
	

#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
