extends CharacterBody2D


const SPEED = 30.0

var starting_pos: Vector2;

func _ready():
	starting_pos = position


func _process(delta):
	
	change_direction('>')
	 
	if Input.is_action_just_pressed("restart"):
		position = starting_pos
	pass
	

func change_direction(where):
	# move direction based on path
	velocity.x = 1 * SPEED
	move_and_slide()
	pass


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
