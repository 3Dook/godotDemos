extends GridContainer

@onready var game_manager = %gameManager

@onready var gridsq = $"."

var gridChildren = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in gridsq.get_children():
		gridChildren.append(child)
		# connect each grid node to gameManager - node. 

	# add nodes into the grid
	
	
	print(gridChildren)
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(delta):
	pass
