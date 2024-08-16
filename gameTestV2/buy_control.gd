extends Control


@onready var back_g = $CenterContainer/Panel/backG
@onready var visual = $CenterContainer/Panel/visual
@onready var label = $CenterContainer/Panel/Label

@onready var buy_ref
@onready var chickenSprite = preload("res://assests/Free Chicken Sprites.png")
@onready var appleSprite = preload("res://assests/apple.png")
signal buy_clicked
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
	
func set_buy_control(type: int):
	if type == 1:
		# make a chicken or load it up
		visual.texture = chickenSprite
		label.text = 'Chicken\n$: 50'
		visual.hframes = 4
		visual.vframes = 2
	elif type == 2:
		visual.texture = appleSprite
		label.text = 'Apple\n$: 50'
		visual.hframes = 1
		visual.vframes = 1
			
	
	
	
func _on_gui_input(event):
	print('why not')
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT\
			and event.is_pressed():
				print('i been clicked')
				#buy_clicked.emit(get_index(), event.button_index, self)


func _on_mouse_entered():
	print('hovering')
	pass # Replace with function body.


func _on_button_button_down():
	print('why')


func _on_button_pressed():
	print('testtting', self)
	# put the item onto the player's hand - if there is money to be spent 
