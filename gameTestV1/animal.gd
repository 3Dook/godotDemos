extends CharacterBody2D

class_name Animal

signal sold_animal



var SPEED = 300.0
var nickname: String
var food: String
var age: int
var appeal: int
var cost: int
var reproduce: float
var produce: String
var excrete: String
var value : int

var has_mouse: bool = false
var is_dragging = false #state management

var move_direction : Vector2 = Vector2.ZERO

func _init(newFood := "money", name := "nobody"):
	food = newFood
	# new 
	nickname = "nobody" 
	age = 0
	appeal = 10
	cost = 10
	reproduce = 0.5
	produce = "Air"
	excrete = "poop"
	value = cost / 2
	
func say_self():
	print("I am ", name)
	print("nickname - ", nickname)
	print("age -", age)
	print("my appeal - ",appeal)
	print("Cost - ", cost)
	print("Reproduce -", reproduce)
	print("Produce - ", produce)
	print("excrete - ", excrete)



func eat():
	print("eating " + food)
	
func wander():
	pass

func _ready():
	$Timer.start()
	select_new_direction()


func _physics_process(delta):
	#if has_mouse and Input.is_action_just_pressed("left_click"):
	#	global_position = get_global_mouse_position()
	if is_dragging == true:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position(), 0.01)
	velocity = move_direction * SPEED * delta * 2
	move_and_slide()
	
	
	

func select_new_direction():
	move_direction = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	)


func _on_timer_timeout():
	age += 1
	value += age / 2
	select_new_direction()
	$Timer.start()
	#say_self()

"""
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if has_mouse:
				is_dragging = true
			else: 
				is_dragging = false
		else:
			is_dragging = false
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		print("collect me ")
		
	
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = true
			#say_self()

		else:
			is_dragging = false
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			sell_self()
	
"""
"""
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if has_mouse:
				#say_self()
				is_dragging = true
			else: 
				is_dragging = false
		else:
			is_dragging = false
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			if has_mouse:
				sell_self()
"""



func sell_self():
	emit_signal("sold_animal", value)
	self.queue_free()

func reposition_self(posX, posY):
	self.position.x = posX
	self.position.y = posY




func _on_mouse_entered():
	has_mouse = true
	


func _on_mouse_exited():	
	has_mouse = false
