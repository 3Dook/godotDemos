extends StaticBody2D

@onready var click_area = $Area2D/clickArea
@onready var collision_area = $CollisionArea

@onready var item_visual = $item_visual
@onready var quantity_label = $item_visual/quantityLabel

@export var slot_ref: SlotData
# Called when the node enters the scene tree for the first time.
# two signals one to tell it got released from a slot or.... pressed
signal item_clicked
signal item_released

var area_entered: bool = false


func set_item_data(slot_data: SlotData):
	if slot_data:
		slot_ref = slot_data
		item_visual.texture = slot_ref.item_data.texture
		if slot_data.quantity > 1:
			quantity_label.show()
			quantity_label.text = str(slot_data.quantity)
		else:
			quantity_label.hide()
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT\
			and !event.is_pressed():
		item_released.emit(self)
		#print('RELEASE RELEASY')
		#else: 
			##print('elsewhere')
			#slot_released_elsewhere.emit()
	elif event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT\
			and event.is_pressed():
		item_clicked.emit(self)
		#print('CLICKLY CCLICKY')


func _on_area_2d_area_entered(area):
	#print('hello world' , area)
	var parent_node = area.get_parent()
	#print(parent_node.slot_ref.item_data.name)
	if parent_node.slot_ref.item_data.name == slot_ref.item_data.name:
		if !area_entered:
			if slot_ref.can_fully_merge_with(parent_node.slot_ref):
				slot_ref.fully_merge_with(parent_node.slot_ref)
				#parent_node.queue_free()
				parent_node.area_entered = true
				parent_node.queue_free()			
	set_item_data(slot_ref)


# process if mouse is over and grab_slot is visible and item_data.name match >>> queue  free
