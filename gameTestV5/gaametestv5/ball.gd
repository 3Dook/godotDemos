extends CharacterBody2D

class_name Ball
var SPEED = 2
var SPEED_MULT = 1.02
@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal countdown
func _ready():
	# create a random function here to start the ball w.e
	start_ball()
func _process(delta: float) -> void:
	#move_and_slide()
	var collison = move_and_collide(velocity * SPEED)
	
	if(collison):
		velocity = velocity.bounce(collison.get_normal()) * SPEED_MULT
		if collison.get_collider() is Paddle:
			audio_stream_player_2d.play()

func start_ball():
	print('starting ball')
	global_position = Vector2(560, 290)
	SPEED = 2
	velocity = Vector2(0,0)
	countdown.emit()
	timer.start()
	await timer.timeout
	animation_player.play("walking")
	randomize()
	velocity.x = [-1, 1][randi() % 2] * SPEED
	velocity.y = [-.8, .8][randi() % 2] * SPEED


func set_ball(save_data):
	print('setting ball')
	self.postion.x = save_data.posX
	self.position.y = save_data.posY
	velocity = save_data.velocity
	countdown.emit()
	timer.start()
	await timer.timeout
	animation_player.play("walking")
	
func save_ball():
	return {
		"posX" = position.x,
		"posY" = position.y,
		"velocity" = velocity
	}  
	
