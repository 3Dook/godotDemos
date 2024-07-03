extends Node

#preload animals or w.e we need
var NEW_CHICKEN = preload("res://chicken.tscn")
var NEW_ANIMAL = preload("res://animal.tscn")
var temp_egg = preload("res://egg_collectable.tscn")
var ref_inv = preload("res://inventory/inventory_ui.tscn")
@onready var user_score = %userScore
@onready var inv_ui = $"../inv_ui"

@onready var grabslot = inv_ui.get_node('grabbed_slot')
#Game Variables
var MONEY : int
var Day : int

#inventory
@export var inventory = Inventory

#signal
signal collecting_egg
signal update_grabbed_slot

# Called when the node enters the scene tree for the first time.
func _ready():
	MONEY = 100
	Day = 0
	#var grabslot = inv_ui.get_node('grabbed_slot')
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
	newC.made_egg.connect(self.collect_egg)
	get_node("/root/Game/inv_ui/AnimalTracker").add_child(newC)

func collect_egg(item):
	# item_instance.connect(signal, self, self.funcTo do something)
	item.COLLECT_EGG.connect(self.do_something_with_collect_egg)
	item.add_to_grabbed_slot.connect(set_to_grabbedslot)
	print('collectnig eggs shjould be good')
	#print(item)
	
func do_something_with_collect_egg(egg):
	emit_signal("collecting_egg", egg)
	#print("this should go into inventory", egg)
	
func drop_an_item_from_inventory(slot: SlotData):
	print(slot)
	
	
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

func _unhandled_input(event):
	# left button push 
	if event is InputEventMouseButton and grabslot.is_visible():
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				print("Left mouse button pressed at position:", event.position)
				print(grabslot.slot_ref)
				_on_inv_ui_drop_data_main(grabslot.slot_ref, grabslot)
			else:
				print("Left mouse button released at position:", event.position)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed():
				print("Right mouse button pressed at position:", event.position)
			else:
				print("Right mouse button released at position:", event.position)
	"""
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		print('held down ')	
	elif Input.is_action_pressed("left_click"):
		print('oh something happening')
		print("mouse is at ", get_viewport().get_mouse_position())
		if grabslot.is_visible():
			print('its visble')
		else:
			print("its hidden")
	"""

func drop_slot_into_main():
	""" 
		if slot.item_data.name == "Egg" and slot.quantity > 0:
		var egg = temp_egg.instantiate()
		egg.position = get_viewport().get_mouse_position()
		collect_egg(egg)
		get_node("/root/Game/inv_ui/AnimalTracker").add_child(egg)
		slot.quantity -= 1
		if slot.quantity == 0:
			update_grabbed_slot.emit()

		grab_slot.set_slot_data(slot)
	""" 

		# update inventory
func _pick_up_collectable():
	
	pass
func set_to_grabbedslot(slot: SlotData):
	print("need to set to grabslot")
	# set aa slot then use the function
	if grabslot.is_visible():
		# do nothing
		pass
	else:
		# pick it up
		grabslot.set_slot_data(slot)
		update_grabbed_slot_main()
		
func _on_inv_ui_drop_data_main(slot: SlotData, grab_slot):
	print("droping into overworld ", slot.item_data.name)
	print("grab slot is ", grab_slot)
	
	if slot.item_data.name == "Egg" and slot.quantity > 0:
		var egg = temp_egg.instantiate()
		egg.position = get_viewport().get_mouse_position()
		collect_egg(egg)
		get_node("/root/Game/inv_ui/AnimalTracker").add_child(egg)
		slot.quantity -= 1
		if slot.quantity == 0:
			update_grabbed_slot.emit()

		grab_slot.set_slot_data(slot)
		# update inventory

func update_grabbed_slot_main():
	if grabslot.slot_ref:
		grabslot.show()
	else:
		grabslot.hide()
