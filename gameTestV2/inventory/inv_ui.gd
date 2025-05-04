extends CanvasLayer

@onready var inventory: Inventory = preload("res://inventory/game_inventory.tres")
#@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

const Slot = preload("res://inventory/inv_slot.tscn")

const testTemp = preload("res://item_collectable.tscn")

@onready var grid_container = $NinePatchRect/GridContainer
@onready var grab_slot = $grab_slot
# use to test to see if there stuff in grab_slot
@onready var grabbed_slot_data: SlotData
var temp_Collectable = preload("res://egg.tres")
var previousSlot: int
var nextSlot: int



var is_open = false
@onready var click_timer = $clickTimer
@onready var double_timer = $doubleTimer
var doubleClickFlag: bool = false
# Called when the node enters the scene tree for the first time.

# make sure no function from outside affects control nodes from inventory
var mouse_over_control: bool = false
var mouse_over_slot: bool = false

func _ready():
	inventory.updateInventoryUI.connect(update_slots)
	update_slots(inventory)
	close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()
	if grab_slot.visible:
		grab_slot.global_position = grab_slot.get_global_mouse_position() + Vector2(5,5)
	
	#if !Input.is_action_pressed("left_click") and grab_slot.visible:
		#print('wrong fix it here?')
	if Input.is_action_just_pressed("add_test"):
		var temp = SlotData.new()
		temp.set_slotData(temp_Collectable.duplicate())
		#print(temp)
		create_item(temp, Vector2(650, 250), 0)

func create_item(slot: SlotData, at: Vector2, flag: int):
	var new_item = testTemp.instantiate()
	new_item.position = at
	#print(slot)
	
	#signals
	new_item.item_clicked.connect(on_collect_clicked)
	new_item.item_released.connect(on_collect_release)	
	
	get_node("/root/Game/AnimalTracker").add_child(new_item)
	
	if flag:
		print('single')
		var temp = SlotData.new()
		temp.set_slotData(temp_Collectable.duplicate())
		new_item.set_item_data(temp)
	else:
		new_item.set_item_data(slot)

func on_collect_clicked(collect):
	#print('cliked', collect)

	if grab_slot.visible:
		#print("whoops theres a item here")
		pass
	else:
		#print(collect.slot_ref)
		grab_slot.set_visual_data(collect.slot_ref.duplicate())
		#inventory.itemsArray[index] = null
		# release the collect
		#collect.modulate.a = 0.5
		collect.queue_free()
		grab_slot.visible = true
		click_timer.start(0.15)

func on_collect_release(collect):
	if click_timer.get_time_left() and double_timer.get_time_left():
		# remaining time : set double check flag 
		#print('double clicked on collect')
		pass
	elif click_timer.get_time_left():
		doubleClickFlag = true
		double_timer.start(0.15)
		#print('single click on collect')
		#if grab_slot.visible:
			#grab_slot.set_visual_data(inventory.drop_slot_data(grab_slot.slot_ref, index))
		# do single click
	#else: 
		# held - because you held onto it hence time left
		#print('release - just drop item into slot orr.... on ground')
		# if overlapping control 
		#if mouse_over_slot:
			#print('drop into slot')
		#else:
			#print('released here from ui at random spot')
			#create_item(grab_slot.slot_ref, grab_slot.get_global_mouse_position())
			#grab_slot.reset_slot_data()

func update_slots(inven):
	#for i in range(min(inventory.itemsArray.size(), slots.size())):
	#		slots[i].set_slot_data(inventory.itemsArray[i])
	for child in grid_container.get_children():
		child.queue_free()
	
	for slot_data in inventory.itemsArray:
		var slot = Slot.instantiate()
		grid_container.add_child(slot)
		
		slot.slot_released.connect(on_slot_released)
		slot.slot_released_elsewhere.connect(on_slot_elsewhere)
		slot.slot_clicked.connect(on_slot_clicked)
		slot.slot_clicked_right.connect(on_slot_right_clicked)
		slot.mouse_entered_control.connect(mouse_entered_slot)
		slot.mouse_exited_control.connect(mouse_exit_slot)
		
		if slot_data:
			slot.set_slot_data(slot_data)
	
	#print(inventory.itemsArray)
func on_slot_right_clicked(index):
	if grab_slot.visible:
		#print("place into slot if possible")
		# else: reject if not the same item
		grab_slot.set_visual_data(inventory.drop_single_slot_data(grab_slot.slot_ref, index))
	else:
		print('do item action')

func on_slot_released(index):
	if click_timer.get_time_left() and double_timer.get_time_left():
		# remaining time : set double check flag 
		#print('double clicked on slot released')
		pass
	elif click_timer.get_time_left():
		doubleClickFlag = true
		double_timer.start(0.15)
		#print('single click on slot')
		if grab_slot.visible:
			grab_slot.set_visual_data(inventory.drop_slot_data(grab_slot.slot_ref, index))
		# do single click
	else: 
		# held - because you held onto it hence time left
		# but this might be useless since it will affect the others 
		#print('held starting at ', previousSlot, ' - release at another spot released on next index', index)
		
		if grab_slot.visible:
			grab_slot.set_visual_data(inventory.drop_slot_data(grab_slot.slot_ref, index))
	
	update_slots(inventory)
		
func on_slot_elsewhere():
	#print("it got releaaased else where @ - ", grab_slot.get_global_mouse_position())
	pass

func on_slot_clicked(index, _mouseIndex, origin):
	#print("the index - ", index, " mouse - ", mouseIndex)
	previousSlot = index
	# if there is a slot data at the index - then store to 
	# if there is an item there and grab_slot is visible then swap the items
	if inventory.itemsArray[index] and grab_slot.visible:
		#print("swap items ")
		if inventory.itemsArray[index].item_data and grab_slot.slot_ref.item_data:
			#print("same items")
			# MERGE THE SAME ITEMS IF POSSIBLE
			grab_slot.set_visual_data(inventory.drop_slot_data(grab_slot.slot_ref, index))
			
	elif inventory.itemsArray[index]:
		#print('there an item there')
		grab_slot.set_visual_data(inventory.itemsArray[index])
		inventory.itemsArray[index] = null
		grab_slot.visible = true
		origin.modulate.a = 0.5

	click_timer.start(0.15)


func _unhandled_input(event):
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT\
			and !event.is_pressed()\
			and !mouse_over_control\
			and !mouse_over_slot\
			and grab_slot.visible:
		#print('released here from ui at random spot')
		create_item(grab_slot.slot_ref, grab_slot.get_global_mouse_position(), 0)
		grab_slot.reset_slot_data()
		update_slots(inventory)
	
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_RIGHT\
			and event.is_pressed()\
			and !mouse_over_control\
			and !mouse_over_slot\
			and grab_slot.visible:
		print('right button use')
		# if there is a slot 
		if grab_slot.slot_ref.quantity > 1:
			# add a single or multiple function
			create_item(grab_slot.slot_ref, grab_slot.get_global_mouse_position(), 1)
			grab_slot.slot_ref.quantity -= 1
			# update grab_slot
			grab_slot.set_visual_data(grab_slot.slot_ref)
		else:
			create_item(grab_slot.slot_ref, grab_slot.get_global_mouse_position(), 0)
			grab_slot.reset_slot_data()
			update_slots(inventory)
		
func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false

func _on_double_timer_timeout():
	doubleClickFlag = false
	double_timer.stop()


func _on_click_timer_timeout():
	click_timer.stop()


func _on_nine_patch_rect_mouse_entered():
	mouse_over_control = true

func _on_nine_patch_rect_mouse_exited():
	mouse_over_control = false

func mouse_entered_slot():
	#print('mouse over')
	mouse_over_slot = true

func mouse_exit_slot():
	#print('mouse_left')
	mouse_over_slot = false
	
