extends Control

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_visual
@onready var quantity_label = $CenterContainer/Panel/item_visual/qtyLabel

@export var slot_ref: SlotData

@onready var on_hover: bool = false

@onready var click_timer = $ClickTimer

@onready var held: bool = false
@onready var back_g = $CenterContainer/Panel/backG

@export var do_not_focus: bool = true

# two signals one to tell it got released from a slot or.... pressed
signal slot_clicked
signal slot_released
signal slot_released_elsewhere

signal slot_clicked_right

# signal
signal mouse_entered_control
signal mouse_exited_control


func reset_slot_data():
	slot_ref = SlotData.new()
	visible = false

func set_slot_data(slot_data: SlotData):
	slot_ref = slot_data
	var item_data = slot_data.item_data
	item_visual.texture = item_data.texture
	if slot_data.quantity > 1:
		quantity_label.show()
		quantity_label.text = str(slot_data.quantity)
	else:
		quantity_label.hide()

func set_visual_data(slot_data: SlotData):
	if slot_data == null:
		slot_ref = null
		visible = false
	else:
		slot_ref = slot_data
		back_g.hide()
		var item_data = slot_data.item_data
		item_visual.texture = item_data.texture
		if slot_data.quantity > 1:
			quantity_label.show()
			quantity_label.text = str(slot_data.quantity)
		else:
			quantity_label.hide()
		
func _on_gui_input(event):
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT\
			and !event.is_pressed():
		if on_hover:
			#print('released ', get_index())
			slot_released.emit(get_index())
		else: 
			#print('elsewhere')
			slot_released_elsewhere.emit()
	elif event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT\
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index, self)
		#print(get_index(), event.button_index) 
	
	elif event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_RIGHT\
			and event.is_pressed():
		slot_clicked_right.emit(get_index())
		
func _on_mouse_entered():
	if do_not_focus:
		grab_click_focus()
		on_hover = true
		mouse_entered_control.emit()
		


func _on_mouse_exited():
	on_hover = false
	mouse_exited_control.emit()
