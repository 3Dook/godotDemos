extends Node


# get a signal - from when a mouse hovers over 
@onready var gridsq = $"../Gridsq"
var gridChildren = []
var passHover = []

signal slot_hovered
signal slot_left

var focusedSlot = false
var slotPos = 99
var mouse_held = false

const NUMBERS = preload("res://numbers.tscn")
const FINAL = preload("res://final.tscn")



func _ready():
	for child in gridsq.get_children():
		gridChildren.append(child)
		child.slot_hovered.connect(on_slot_hover)
		child.slot_left.connect(on_slot_left)
	# connect mouse buttons aasa well
	# appending random number and get another final number
	var random_start = randi_range(0, 24)  
	var random_final = randi_range(0, 24)  
	
	print(random_start)
	var startRandom = NUMBERS.instantiate();
	gridChildren[random_start].add_child(startRandom)
	
	print(random_final)
	var finalRandom = FINAL.instantiate()
	gridChildren[random_final].add_child(finalRandom)


func on_held_change_direction():
	# using hte hover function move accordingly. the direction
	if focusedSlot and slotPos != 99:
		# change the direction of stuff
		pass

func on_slot_hover(pos):
	#print("HOVERING - OVER SLOT slot - ",pos )
	focusedSlot = true
	slotPos = pos
	#if mouse_held:
	passHover.insert(0, pos)
	if mouse_held:
		gridChildren[passHover[0]-1].set_whereNext()
		
	if mouse_held and  passHover.size() > 1:
		# it means we entered a new spot from previous position 
		# set direction from the previous (if its not a number)
		# note the one that should be change should always be pos[1]
		gridChildren[passHover[1]-1].set_direction(gridChildren[passHover[0]-1])
		#print(passHover)
	
func on_slot_left(pos):
	#print("SLOT LEFT pos - ", pos)
	# if mouse_held - add to a list or else it resets
	#check is slot has a question mark -
	if  passHover.size() > 1 and gridChildren[passHover[0]-1].text_label.text == "?":
		gridChildren[passHover[0]-1].set_clearNext()
	focusedSlot = false
	slotPos = 99


func _on_mouse_mouse_clicked():
	print('mouse clicked from game Manager')


func _on_mouse_mouse_double_clicked():
	print('mouse doubleClicked from game Manager')

func _on_mouse_mouse_held():
	#print('mouse held from game Manager')
	mouse_held = true


func _on_mouse_mouse_held_release():
	#print('mouse held_release from game Manager')
	mouse_held = false
	if focusedSlot: #becuase we didn't make a direction
		gridChildren[passHover[0]-1].set_clearNext()
	passHover.clear()
	
