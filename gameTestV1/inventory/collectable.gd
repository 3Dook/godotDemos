extends Resource

class_name Collectable

@export var name: String = ""
@export var texture: Texture2D
@export var stackable: bool = true


func do_something():
	print("i am a collectable named ", name)
