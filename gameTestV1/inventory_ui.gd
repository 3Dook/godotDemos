extends Control

@onready var inventory: Inventory = preload("res://game_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	update_slots()
	close()


func update_slots():
	for i in range(min(inventory.itemsArray.size(), slots.size())):
		slots[i].update(inventory.itemsArray[i])

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
