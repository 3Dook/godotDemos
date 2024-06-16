extends Animal

signal made_egg
#func _init(new_age):
#	age = new_age
var tempEgg = preload("res://egg_collectable.tscn")


func _init(newFood := "seeds", nickname := "chicken"):
	food = newFood
	# new 
	nickname = nickname 
	age = 0
	appeal = 10
	cost = 10
	reproduce = 0.5
	produce = "Air"
	excrete = "poop"
	value = cost / 2
	
	
func _ready():
	$hatchTimer.start()


func hatch_egg():
	var egg = tempEgg.instantiate()
	egg.position.x = self.position.x
	egg.position.y = self.position.y
	emit_signal("made_egg", egg)
	get_node("/root/Game/BaseLevel/animalTracker").add_child(egg)
	$hatchTimer.start()
