extends Node


# get a signal - from when a mouse hovers over 
@onready var gridsq = $"../Gridsq"
var gridChildren = []

signal slot_hovered
signal slot_left

var focusedSlot = false
var slotPos = 99

func _ready():
		for child in gridsq.get_children():
			gridChildren.append(child)
			child.slot_hovered.connect(on_slot_hover)
			child.slot_hovered.connect(on_slot_left)
		# connect mouse buttons aasa well


func on_held_change_direction():
	# using hte hover function move accordingly. the direction
	if focusedSlot and SlotPos != 99:
		# change the direction of stuff
		pass

func on_slot_hover(pos):
	print("HOVERING - OVER SLOT slot - ",pos )
	focusedSlot = true
	slotPos = pos
	
func on_slot_left(pos):
	print("SLOT LEFT pos - ", pos)
	focusedSlot = false
	slotPos = 99


func _on_mouse_mouse_clicked():
	print('mouse clicked from game Manager')


func _on_mouse_mouse_double_clicked():
	print('mouse doubleClicked from game Manager')

func _on_mouse_mouse_held():
	print('mouse held from game Manager')


func _on_mouse_mouse_held_release():
	print('mouse held_release from game Manager')
