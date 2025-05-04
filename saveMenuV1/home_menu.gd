extends Control


func play_game():
	get_tree().change_scene_to_file("res://save_load_container.tscn")

func options_game(): 
	get_tree().change_scene_to_file("res://option_container.tscn")

func quit_game():
	get_tree().quit()
