extends Node


#TODO: 
	#1. make a grid to position function
	#2. update each use once done. start_position


@onready var mouse = $"../Mouse"

# get a signal - from when a mouse hovers over 
@onready var gridsq = $"../Gridsq"
var startLocation;
var startPosition;

var startMoving = false

var gridChildren = []
var gridArray = []
var passHover = []

signal slot_hovered
signal slot_left

var focusedSlot = false
var slotPos = 99
var mouse_held = false

const NUMBERS = preload("res://numbers.tscn")
const FINAL = preload("res://final.tscn")

var numbFactory;

func _ready():
	for child in gridsq.get_children():
		#print(child.position)
		#print(child.global_position)
		gridChildren.append(child)
		child.slot_hovered.connect(on_slot_hover)
		child.slot_left.connect(on_slot_left)
	# connect mouse buttons aasa well
	
	gridArray = list_to_grid(gridChildren, 5)
	print(gridArray)
	# appending random number and get another final number
	var random_start = randi_range(0, 24)  
	var random_final = randi_range(0, 24)  
	
	#print(random_start)
	random_start = 12
	var startRandom = NUMBERS.instantiate();
	
	
	#gridChildren[random_start].add_child(startRandom)
	#print(gridChildren[random_start].global_position)
	startPosition = get_square_postion(gridChildren[random_start])
	#print(startPosition)
	startLocation = get_slot_global_position(gridChildren[random_start])
	
	startRandom = NUMBERS.instantiate()
	startRandom.target_position = startLocation
	startRandom.position = startLocation
	add_child(startRandom)
	numbFactory = startRandom
	
	
	#print(random_final)
	#var finalRandom = FINAL.instantiate()
	#gridChildren[random_final].add_child(finalRandom)
	
	# try to find there local position
	#get_slot_global_position(gridChildren[random_start])
	#print(get_slot_position(get_square_postion(gridChildren[random_start])))

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		# start factor 
		find_direction_squares(startPosition)
		startMoving = !startMoving

	
	#if startMoving:
		#find_direction_squares(startPosition)


func find_direction_squares(srePos):
	# a function that takes in a srePos - and returns a list of directions 1,2,3,4 - clockwise
	# as long as it hits a direction
	var rowCol = get_slot_position(srePos)
	# !!!! THIS IS FLIP - for Col and Row - 
	var temp = rowCol.x
	rowCol.x = rowCol.y
	rowCol.y = temp
	#print(rowCol)
	#top
	#print(gridArray[rowCol.x - 1][rowCol.y])
	#print(gridArray[rowCol.x - 1][rowCol.y].text_label.text)
	if rowCol.x > 0 and gridArray[rowCol.x - 1][rowCol.y].text_label.text == "^":
			print('this is a hit - move up')
			#print(get_slot_global_position(gridArray[rowCol.x - 1][rowCol.y]))
			numbFactory.target_position = get_slot_global_position(gridArray[rowCol.x - 1][rowCol.y])
	#right 
	if rowCol.y < gridArray.size() - 1 and gridArray[rowCol.y][rowCol.x + 1].text_label.text == ">":
		print('this is a hit - right ')
		numbFactory.target_position = get_slot_global_position(gridArray[rowCol.y][rowCol.x + 1])
	#bottom
	if rowCol.x < gridArray.size() - 1 and gridArray[rowCol.x + 1][rowCol.y].text_label.text == "v":
		print('this is a hit - move down')
		numbFactory.target_position = get_slot_global_position(gridArray[rowCol.x + 1][rowCol.y])
	#left
	if rowCol.y > 0 and gridArray[rowCol.x][rowCol.y - 1].text_label.text == "<":
		print('this is a hit - move left')
		numbFactory.target_position = get_slot_global_position(gridArray[rowCol.x][rowCol.y - 1])

#TODO: 
	#1. make a grid to position function
	#2. update each use once done. start_position

func get_square_postion(srePos):
	return srePos.name.substr(6, srePos.name.length()-6).to_int()

func get_slot_position(square):
	# because global position does not work due to a weird interaction we need to find the center
	# position of each godot value - each square is 128,128 - so we should count up to 128 + 64 + number of gaps to get center of each
	var row = floor((square - 1) / 5)
	var col = (square - 1) % 5
	return Vector2(col, row) 

func get_slot_global_position(srePos):
	
	var slot_vector: Vector2 = get_slot_position(get_square_postion(srePos))
	print(slot_vector)
	#((slot_vector.x - 1) * 128) + (slot_vector.x * 2.8) + 
	# at x=1 = 358 ~= 340
	# at x=2 = 442 - 339 delta 103
	# at x=3 535 - 442 = 93
	# at x=4 
	
	slot_vector.x = (64 + 294 - 19) + (slot_vector.x * 100)
	slot_vector.y = (slot_vector.y * 100) + 64 + 72 - 15
	print(slot_vector)
	return slot_vector

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


func list_to_grid(array, col_size):
	var grid = []
	for i in range(0, array.size(), col_size):
		grid.append(array.slice(i, i + col_size))
	return grid


func _on_mouse_mouse_clicked():
	print('mouse clicked from game Manager at position ', mouse.get_global_mouse_position())


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
	
