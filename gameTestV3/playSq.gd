extends Control

@onready var focused = $CenterContainer/focused
@onready var center_container = $CenterContainer
@onready var color_rect = $CenterContainer/Panel/backG/ColorRect
@onready var panel = $CenterContainer/Panel


var on_hover = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _get_drag_data(at_position):
	print('get_drag')
	print(at_position, self)
	# make the a dictionary with the data 
	return 1;

func _can_drop_data(at_position, data):
	print('can drop dataaa')
	print(at_position, self)
	print(data)
	
	return data == 1;

func _drop_data(at_position, data):
	print('droping data')	
	print(at_position, self);
	print(data)
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func _on_mouse_entered():
	color_rect.visible = true


func _on_mouse_exited():
	if not Rect2(panel.get_global_rect()).has_point(get_global_mouse_position()):
		color_rect.visible = false

func _on_focus_entered():
	print('i am focused')


func _on_focus_exited():
	print('not focused')
