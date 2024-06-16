extends Resource

class_name Inventory

@export var itemsArray: Array[Collectable]

signal updateInventoryUI

func insert(item: Collectable):
	"""
		var itemslots = itemsArray.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else: 
		var emptyslots = itemsArray.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	"""
	# find if there is already an item inside the array
	# then add
	# else add to the first empty slot
	
	var itemslots = find_all(itemsArray, item) 

	if itemslots.is_empty():
		# can't find anything
		var first = find_first_empty(itemsArray)
		itemsArray[first] = item
	else:
		# tehre are index found
		var flag = true
		
		for i in itemslots:
			if itemsArray[i].amount == itemsArray[i].maxAmount:
				continue
			elif itemsArray[i].amount < itemsArray[i].maxAmount:
				itemsArray[i].amount += 1
				flag = false
				break
		if flag:
			var first = find_first_empty(itemsArray)
			itemsArray[first] = item

	updateInventoryUI.emit()

func insert_directly(item):
	pass

func find_all(array, item: Collectable):
	var results = []
	
	for i in range(array.size()):
		if array[i] != null and array[i].name == item.name:
			results.append(i)
	return results

func find_first_empty(array):
	for i in range(array.size()):
		if array[i] == null:
			return i
