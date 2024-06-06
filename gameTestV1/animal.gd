extends CharacterBody2D

class_name Animal

var SPEED = 300.0
var nickname: String
var food: String
var age: int
var appeal: int
var cost: int
var reproduce: float
var produce: String
var excrete: String

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
	velocity = move_direction * SPEED * delta
	move_and_slide()

func select_new_direction():
	move_direction = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	)


func _on_timer_timeout():
	select_new_direction()
	$Timer.start()
	#say_self()

"""
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			say_self()
"""


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			say_self()
