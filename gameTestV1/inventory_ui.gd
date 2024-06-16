extends Control

@onready var inventory: Inventory = preload("res://game_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var tempEgg = preload("res://egg.tres")

var is_open = false

func _ready():
	inventory.updateInventoryUI.connect(update_slots)
	update_slots()
	close()


#collect chicken 
func collect(item):
	var newResource = Collectable.new()
	newResource.name = "egg"
	newResource.texture = preload("res://assests/Egg_item.png")
	newResource.amount = 1
	newResource.maxAmount = 2 
	#inventory.insert(item)
	inventory.insert(newResource)


func update_slots():
	for i in range(min(inventory.itemsArray.size(), slots.size())):
		slots[i].update(inventory.itemsArray[i])

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()
	if Input.is_action_just_pressed("testCollect"):
		#  create a new resrouce and all
		var temp = tempEgg.duplicate()
		collect(tempEgg)
func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
