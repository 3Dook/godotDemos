extends Control

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_visual
@onready var quantity_label = $CenterContainer/Panel/item_visual/quantityLabel

@export var slot_ref: SlotData

signal slot_clicked


func set_slot_data(slot_data: SlotData):
	slot_ref = slot_data
	var item_data = slot_data.item_data
	item_visual.texture = item_data.texture
	if slot_data.quantity > 1:
		quantity_label.show()
		quantity_label.text = str(slot_data.quantity)
	else:
		quantity_label.hide()

	
func _on_gui_input(event):
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)







