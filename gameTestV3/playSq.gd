extends Control

@onready var focused = $CenterContainer/focused
@onready var center_container = $CenterContainer
@onready var color_rect = $CenterContainer/Panel/backG/ColorRect
@onready var panel = $CenterContainer/Panel
@onready var item = $CenterContainer/Panel/item
@onready var text_label = $CenterContainer/Panel/direction/RichTextLabel

var on_hover = false;

# Signal

# we already have a click button somewhere else - just need to know if mouse hover over or not
signal slot_hovered
signal slot_left



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#func _set_direction(direc):
	#text_label.text = direc
#
#func _get_drag_data(at_position):
	## make the a dictionary with the data 
	## start with the drag location.
	## if there is data in the there square then it starts 
#
	#print('start get')
	#return self;
	##if !text_label.text:
		##return self;
	##else:
		##print("ending ")
		#
#func _can_drop_data(at_position, data):
	#return true
#
#func _drop_data(at_position, data):
	#print('droping data')	
	#print(data)
	#print(self);
	## use vector make to find direction
	## set previous direction to the direction of math
	#data.text_label.text = get_direction(get_square_postion(data), get_square_postion(self))
func set_whereNext():
	self.text_label.text = "?"

func set_clearNext():
		self.text_label.text = ""
	
func set_direction(nextSlot):
	self.text_label.text = get_direction(get_square_postion(self), get_square_postion(nextSlot))

func get_square_postion(srePos):
	return srePos.name.substr(6, srePos.name.length()-6).to_int()

func square_to_position(square):
		var row = floor((square - 1) / 5)
		var col = (square - 1) % 5
		return Vector2(row, col) 

func get_direction(sq1, sq2):
	var pos1 = square_to_position(sq1)
	var pos2 = square_to_position(sq2)

	var row_diff = pos2.x - pos1.x
	var col_diff = pos2.y - pos1.y

	if row_diff == -1 and col_diff == 0:
		return "^"
	elif row_diff == 1 and col_diff == 0:
		return "v"
	elif row_diff == 0 and col_diff == -1:
		return "<"
	elif row_diff == 0 and col_diff == 1:
		return ">"
	#elif row_diff == -1 and col_diff == -1:
		#return "Up-Left"
	#elif row_diff == -1 and col_diff == 1:
		#return "Up-Right"
	#elif row_diff == 1 and col_diff == -1:
		#return "Down-Left"
	#elif row_diff == 1 and col_diff == 1:
		#return "Down-Right"
	else:
		print("no go")
		print(row_diff)
		print(col_diff)
		return ""
	
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
		#
#
#func _on_mouse_entered():
	#color_rect.visible = true
#
#
#func _on_mouse_exited():
	#if not Rect2(panel.get_global_rect()).has_point(get_global_mouse_position()):
		#color_rect.visible = false
#
#func _on_focus_entered():
	#print('i am focused')
#
#
#func _on_focus_exited():
	#print('not focused')

#func _gui_input(event):
	## ignore all mouse pressed
	#if event is InputEventMouseButton and event.pressed:
		##print(event)
		##accept_event()
		#get_tree().get_root().get_node("game").push_input(event)

func _on_mouse_entered():
	#print('entering', self)
	slot_hovered.emit(get_square_postion(self))
	
func _on_mouse_exited():
	#print('leaving', self)
	slot_left.emit(get_square_postion(self))
