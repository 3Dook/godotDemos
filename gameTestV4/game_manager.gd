extends Node

@onready var mouse = $Mouse
@onready var character = $character
@onready var enemy = $enemy

@onready var gake = $gake
@onready var gake_2 = $gake2

@onready var main
@onready var global_mouse = $globalMouse
@onready var controller_label = $controller_label

@onready var mouse_position = Vector2()


var bullet_ab1 = preload("res://egg_blast.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	main = gake


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("one"):
		controller_label.text = '1'
		main = gake
	
	if Input.is_action_just_pressed("two"):
		controller_label.text = '2'
		main = gake_2
		
	if Input.is_action_just_pressed("q"):
		var instance = bullet_ab1.instantiate()
		instance.position = main.position
		
		# between two points
		# 
		#instance.set_move(Vector2(-1,1))
		# conver the mouse position from text to vector
		
		instance.set_move((mouse_position - main.position).normalized())
		add_child(instance)



func _on_mouse_mouse_clicked(pos):
	if Input.is_action_pressed("holdShift"):
		print("holding shift while click")
		main.queueMove(pos)
	else:
		#character._move_character(pos)
		main.forceMove(pos)


func _on_mouse_send_global_position(pos):
	global_mouse.text = "(%s,%s)" % [pos.x, pos.y]
	mouse_position = pos
