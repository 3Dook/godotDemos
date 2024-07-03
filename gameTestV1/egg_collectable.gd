extends StaticBody2D

signal COLLECT_EGG
signal add_to_grabbed_slot

@onready var tempEgg = preload("res://egg.tres").duplicate()
@export var slot_ref: SlotData

var is_dragging:bool = false
var has_mouse:bool = false
#on click will collect an item
#on right click will sell 

#drag will reposition in main world
#drag on UI will reposition inventory UI

# Called when the node enters the scene tree for the first time.
func _ready():
	var temp = SlotData.new()
	temp.set_slotData(tempEgg)
	slot_ref = temp
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dragging == true:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", get_global_mouse_position(), 0.01)


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if has_mouse:
				add_to_grabbed_slot.emit(slot_ref)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			if has_mouse:
				collect_me()


func collect_me():
	COLLECT_EGG.emit(tempEgg)
	self.queue_free()
	

"""
func _on_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = true
		else:
			is_dragging = false
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			print('collect me')
"""

			




func _on_mouse_entered():
	has_mouse = true


func _on_mouse_exited():
	has_mouse = false
