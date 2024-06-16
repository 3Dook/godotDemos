extends Control

@onready var inventory: Inventory = preload("res://game_inventory.tres")
@onready var tempEgg = preload("res://egg_collectable.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var game_manager = $"../GameManager"

#var tempEgg = preload("res://egg.tres")

var is_open = false

func _ready():
	inventory.updateInventoryUI.connect(update_slots)
	#1tempEgg.COLLECT_EGG.connect(collect)
	game_manager.collecting_egg.connect(collect)
	update_slots()
	close()


#collect chicken 
func collect(egg):
	"""
		var newResource = Collectable.new()
	newResource.name = "egg"
	newResource.texture = preload("res://assests/Egg_item.png")
	newResource.amount = 1
	newResource.maxAmount = 2 
	"""
		
	#inventory.insert(item)
	# need to extract an egg resource from the egg scene
	# todo: add an egg resource.
	inventory.insert(egg.tempEgg)


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
		collect(temp)
func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
