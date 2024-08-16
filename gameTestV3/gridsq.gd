extends GridContainer

@onready var gridsq = $"."

var gridChildren = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in gridsq.get_children():
		gridChildren.append(child)

	print(gridChildren)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
