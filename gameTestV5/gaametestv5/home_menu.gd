extends Control

@onready var ConButton: Button = $VBoxContainer/Continue

func _ready() -> void:
	if SaveLoad.check_save_file():
		print("there is something ehre")
		ConButton.visible = true
		
func continue_game():
		SaveLoad.load_game()
		
func play_game():
	get_tree().change_scene_to_file("res://game_manager.tscn")

func options_game(): 
	pass
	get_tree().change_scene_to_file("res://option_container.tscn")

func quit_game():
	get_tree().quit()
