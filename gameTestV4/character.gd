extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


var atTarget = true
var targetPos = Vector2(0,0)

@onready var actionQ = []
var moveQ = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


# TODO 1219 - make adding an action into the action queue then queue it up depending on the conditons.

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
	#if !atTarget and !moveQ:
		#velocity = min(velocity.length(), SPEED) * velocity.normalized()
		#move_and_slide()
		#
		#if (abs(targetPos.y - position.y)) < 10 and (abs(targetPos.x - position.x)) < 10:
			#print(targetPos.y - position.y)
			#print(targetPos.x - position.x)
			#print("position is at -", position, "and target position is at ", targetPos)
			#atTarget = true
	#
	#if moveQ:
		#move_and_slide()
		#
		#if (abs(targetPos.y - position.y)) < 10 and (abs(targetPos.x - position.x)) < 10:
			#print(targetPos.y - position.y)
			#print(targetPos.x - position.x)
			#print("Q position is at -", position, "and Q target position is at ", targetPos)
			#atTarget = true
			#
			# emit signal for the next action
	if !actionQ.is_empty():
		move_and_slide()

		if (abs(targetPos.y - position.y)) < 10 and (abs(targetPos.x - position.x)) < 10:
			print("Q position is at -", position, "and Q target position is at ", targetPos)
			actionQ.pop_front()
			if !actionQ.is_empty():
				# reset the move position action acgain.
				_setAction(actionQ.front())
			else:
				velocity = Vector2(0,0) 
				moveQ = false
				atTarget = true

func _setAction(target):
	atTarget = false
	moveQ = true
	targetPos = target
	# there is a weird feature that doesn't fully show the correct path 
	# of the movement. it tilts in a weird way, 
	velocity.y = targetPos.y - position.y
	velocity.x = targetPos.x - position.x
	velocity = SPEED * velocity.normalized()
	
func _queue_character(target):
	if actionQ.is_empty():
		actionQ.append(target)
		_setAction(target)
	else:
		actionQ.append(target)

func _move_character(target):
	print('working')
	actionQ.clear()
	_queue_character(target)
