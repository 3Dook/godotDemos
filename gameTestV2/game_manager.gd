extends Node

@onready var grid_container = $CanvasLayer/GridContainer
const BUY_CONTROL = preload("res://buy_control.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	update_buy_section()
	pass # Replace with function body.



func make_buy(stuff):
	
	pass


func update_buy_section():
	
	for child in grid_container.get_children():
		child.queue_free()
	
	for i in range(3):
		var temp = BUY_CONTROL.instantiate()
		grid_container.add_child(temp)
		temp.set_buy_control(1)

	for i in range(2):
		var temp = BUY_CONTROL.instantiate()
		grid_container.add_child(temp)
		temp.set_buy_control(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
