extends Resource

class_name Collectable

@export var name: String = ""
@export var texture: Texture2D
@export var amount: int = 1
@export var maxAmount: int = 2


func do_something():
	print("i am a collectable named ", name)
