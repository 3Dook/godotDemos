extends Control

@onready var inventory: Inventory = preload("res://inventory/game_inventory.tres")
#@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

const Slot = preload("res://inventory/inv_ui_slot.tscn")

@onready var grid_container = $NinePatchRect/GridContainer

var is_open = false
var grabbed_slot_data: SlotData
@onready var grabbed_slot = $grabbed_slot

func _ready():
	
	inventory.updateInventoryUI.connect(update_slots)
	update_slots(inventory)
	close()

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()

	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5,5)
func on_slot_clicked(index, mouseIndex):
	print("the index - ", index, " mouse - ", mouseIndex)
	
	match [grabbed_slot_data, mouseIndex]:
		[null, MOUSE_BUTTON_LEFT]:
			# no grabbed_slot and left click on index
			#grabbed_slot_data = inventory.itemsArray[index]
			grabbed_slot_data = inventory.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			# wild card, get the drop slot data
			grabbed_slot_data = inventory.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			# no grabbed_slot and left click on index
			pass
		[_, MOUSE_BUTTON_RIGHT]:
			# wild card, get the drop slot data
			grabbed_slot_data = inventory.drop_single_slot_data(grabbed_slot_data, index)

	
	update_slots(inventory) #add this or else the above doesn't reflect the changes
	update_grabbed_slot()
	

func update_grabbed_slot():
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()
		


func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
	
func update_slots(inven):
	#for i in range(min(inventory.itemsArray.size(), slots.size())):
	#		slots[i].set_slot_data(inventory.itemsArray[i])
	for child in grid_container.get_children():
		child.queue_free()
	
	for slot_data in inventory.itemsArray:
		var slot = Slot.instantiate()
		grid_container.add_child(slot)

		slot.slot_clicked.connect(on_slot_clicked)
		if slot_data:
			slot.set_slot_data(slot_data)
	
	#print(inventory.itemsArray)
