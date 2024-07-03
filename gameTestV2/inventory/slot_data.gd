extends Resource

class_name SlotData

const MAX_STACK_SIZE: int = 9

@export var item_data: Collectable
@export_range(1, MAX_STACK_SIZE) var quantity: int = 1: set = set_quantity

func set_quantity(value: int):
	quantity = value
	if quantity > 1 and not item_data.stackable:
		quantity = 1
		push_error("%s is not stackable, setting quanity to 1" % item_data.name)

func set_slotData(item: Collectable):
	item_data = item

func can_merge_with(other_slot_data: SlotData):
	return item_data.name == other_slot_data.item_data.name and item_data.stackable and quantity < MAX_STACK_SIZE


func can_fully_merge_with(other_slot_data: SlotData):
	#print(item_data.name == other_slot_data.item_data.name) # and item_data.stackable and quantity + other_slot_data.quantity < MAX_STACK_SIZE)
	return item_data.name == other_slot_data.item_data.name and item_data.stackable and quantity + other_slot_data.quantity <= MAX_STACK_SIZE

func fully_merge_with(other_slot_data: SlotData):
	quantity += other_slot_data.quantity

func create_single_slot_data():
	var new_slot_data = duplicate()
	new_slot_data.quantity = 1
	quantity -= 1
	return new_slot_data
