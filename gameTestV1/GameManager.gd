extends Node

#preload animals or w.e we need
var NEW_CHICKEN = preload("res://chicken.tscn")
var NEW_ANIMAL = preload("res://animal.tscn")
@onready var user_score = %userScore

#Game Variables
var MONEY : int
var Day : int

#inventory
@export var inventory = Inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	MONEY = 100
	Day = 0
	$Timer.start()
	updateScore()


func updateScore():
	user_score.text = "MENU\n" + "Money: " + str(MONEY) +"\nDay: " + str(Day) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_chicken():
	
	var newC = NEW_CHICKEN.instantiate()
	MONEY -= newC.cost
	newC.position.x = 500
	newC.position.y = 350
	newC.sold_animal.connect(self.sold_something)
	get_node("../BaseLevel/animalTracker").add_child(newC)


func sold_something(val):
	print("sold an animal for ", val)
	MONEY += val

func add_animal():
	var newC = NEW_ANIMAL.instantiate()
	MONEY -= newC.cost
	newC.position.x = 500
	newC.position.y = 350
	newC.sold_animal.connect(self.sold_something)
	get_node("../BaseLevel/animalTracker").add_child(newC)


func sell_self(target):
	target.queue_free()
	


func _on_timer_timeout():
	Day += 1
	# increment rest of age and do w.e here
	
	#upkeep?
	updateScore()
	$Timer.start()
