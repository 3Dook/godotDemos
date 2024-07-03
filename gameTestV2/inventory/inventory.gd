extends Resource

class_name Inventory

@export var itemsArray: Array[SlotData]

signal updateInventoryUI

func grab_slot_data(index: int):
	var slot_data = itemsArray[index]

	if slot_data:
		itemsArray[index] = null
		updateInventoryUI.emit(self)
		return slot_data
	else:
		return null	

func drop_slot_data(grab_slot_data: SlotData, index: int):
	var slot_data = itemsArray[index]
	
	var return_slot_data: SlotData
	#print(slot_data.can_fully_merge_with(grab_slot_data))
	if slot_data and slot_data.can_fully_merge_with(grab_slot_data):
		#print('this should merge')
		slot_data.fully_merge_with(grab_slot_data)
	else:
		itemsArray[index] = grab_slot_data
		return_slot_data = slot_data
	
	updateInventoryUI.emit(self)
	return return_slot_data
	
	#itemsArray[index] = grab_slot_data
	#updateInventoryUI.emit(self)
	#return slot_data
func drop_single_slot_data(grab_slot_data: SlotData, index: int):
	var slot_data = itemsArray[index]
	
	if not slot_data:
		itemsArray[index] = grab_slot_data.create_single_slot_data()
	elif slot_data.can_merge_with(grab_slot_data):
		slot_data.fully_merge_with(grab_slot_data.create_single_slot_data())
	updateInventoryUI.emit(self)
		
	if grab_slot_data.quantity > 0:
		return grab_slot_data
	else:
		return null
