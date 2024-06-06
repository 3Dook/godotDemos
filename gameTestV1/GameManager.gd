extends Node

#preload animals or w.e we need
var NEW_CHICKEN = preload("res://chicken.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_chicken():
	var newC = NEW_CHICKEN.instantiate()
	newC.position.x = 500
	newC.position.y = 350
	get_node("../BaseLevel").add_child(newC)
