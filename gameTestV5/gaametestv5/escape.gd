extends Control

var flag:bool = false
func _ready() -> void:
	visible = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") and !flag:
		print("escaping")
		visible = true
		get_tree().paused = true
		flag = true
	elif Input.is_action_just_pressed("escape") and flag:
		#swap the flag and continue the game
		continue_game()
		

func continue_game():
	#get_tree().change_scene_to_file("res://game_manager.tscn")
	visible = false
	flag = false
	get_tree().paused = false


func save_escape():
	#go through whatever we wanna save
	SaveLoad.save_game()
	print('save load completed')
	quit_main()
	


func options_game(): 
	pass
	get_tree().change_scene_to_file("res://option_container.tscn")

func quit_main():
	get_tree().paused = false
	flag = false
	get_tree().change_scene_to_file("res://home_menu.tscn")
