extends Control

class_name Card

@onready var sprite_2d: Sprite2D = $Sprite2D


# Make Variables here
@export var value = 0
@export var suit = "spade"
@export var card_ref = 0
var hover: bool = false
@export var clicked: bool = false
var hover_adjust = 10

func set_up(preset) -> void:
	value = preset.value if preset.value != null else 0
	suit = preset.suit if preset.suit != null else "spade"
	card_ref = preset.card_ref if preset.card_ref != null else 0

func _ready() -> void:
	sprite_2d.frame = card_ref
	print("I am made with val ", value, " - ", suit)
	print(self.size)




func _on_mouse_exited() -> void:
	if !clicked:
		self.position.y += hover_adjust
	
func _on_mouse_entered() -> void:
	if !clicked:
		self.position.y -= hover_adjust


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("clickedd")
		clicked = !clicked
		
		if clicked:
			self.position.y -= hover_adjust
		else:
			self.position.y += hover_adjust
