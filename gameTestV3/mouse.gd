extends Node2D

@onready var rich_text_label = $RichTextLabel
var LastPressedTime = 0
var mouseHeld = false
var holding = false

signal mouse_clicked
signal mouse_doubleClicked
signal mouse_held
signal mouse_held_release

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (LastPressedTime > 0):
		LastPressedTime = max(0, LastPressedTime - delta)
		if (LastPressedTime == 0):
			if mouseHeld:
				OnHeldClick(get_local_mouse_position())
				holding = true
			else:
				OnSingleClick(get_local_mouse_position())

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if (event.button_index == MOUSE_BUTTON_WHEEL_UP || event.button_index == MOUSE_BUTTON_WHEEL_DOWN):
			print("scrolling...")
		else:
			if (LastPressedTime > 0):
				OnDoubleClick(get_local_mouse_position())
				LastPressedTime = 0
			else:
				LastPressedTime = 0.3
				# set this to held?
				mouseHeld = true;
	elif event is InputEventMouseButton and event.is_released():
		mouseHeld = false;
		if (LastPressedTime == 0) and holding:
			#print("held release -", get_local_mouse_position())
			mouse_held_release.emit()
			holding = false


func OnDoubleClick(position):
	#print("double: "+str(position.x)+","+str(position.y))
	mouse_doubleClicked.emit()
	
func OnSingleClick(position):
	#print("single: "+str(position.x)+","+str(position.y))
	mouse_clicked.emit()
	
func OnHeldClick(position):
	#print("held: "+str(position.x)+","+str(position.y))
	mouse_held.emit()
# make a method to -
# single click
# double click
# held
# which button

