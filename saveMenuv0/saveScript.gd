extends Node
# This script shows how to save data using the JSON file format.
# JSON is a widely used file format, but not all Godot types can be
# stored natively. For example, integers get converted into doubles,
# and to store Vector2 and other non-JSON types you need `var2str()`.

# note this is a global function that anyone has data to access

# Below is the saave location - change name or use a array to have more save files
const SAVE_PATH = "user://save_v0.json"

var contents_to_save: Dictionary = {
	"foo": "bar",
}



func save_game():
	print('saving gaame')
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	# Note to self - need to update w.e in game so that we have access to save data
	file.store_var(contents_to_save.duplicate())
	file.close()
	
func load_game():
	print("loading game")
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
	var data = file.get_var()
	var save_data = data.duplicate()
	file.close()
	# NTS - reset all the data here
	# contents_to_save.foo = save_data.foo
	

# # below is a list version
# const SAVE_PATH = "user://"
# # on ready it must load up all the loaded files into a load button

# #TODO:
# # make delete button
# # make a game state that actually plays a type of game to load

# var LOADBUTTON = preload("res://load_button.tscn")

# func list_files_in_directory(path):
	# var files = []
	# var dir = DirAccess.open(path)
	# if dir:
		# dir.list_dir_begin()
		# var file_name = dir.get_next()
		# while file_name != "":
			# if dir.current_is_dir():
				# print("Found directory: " + file_name)
			# elif file_name.ends_with(".json"):
				# files.append(file_name)
			# else:
				# print("Found file: " + file_name)
			# file_name = dir.get_next()
	# else:
		# print("An error occurred when trying to access the path.")

	# return files

# func load_game(path):
	# print("loading game" + path)
	
	# """
	
	
	# print(path)
	# var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
	# var json = file.get_as_text()
	
	# var save_data = JSON.parse_string(json)
	
	# #extract data here
		# player.position.x = save_data["playerPosition"][0]
	# player.position.y = save_data["playerPosition"][1]
	
	# print(save_data)
	
	# file.close()
# """

# func new_save():
	# print("making new save")
	# # get name here - 
	# var tempTime = Time.get_unix_time_from_system()
	# var tempName = SAVE_PATH + str(tempTime) + ".json"
	# var file = FileAccess.open(tempName, FileAccess.WRITE)
	# var save_data = {"createdTime": tempTime}
	# print(save_data)
	# var json =JSON.stringify(save_data)
	
	# file.store_string(json)
	# file.close()
	
	
# func goto_main_menu():
	# get_tree().change_scene_to_file("res://home_menu.tscn")

# func _ready():
	# var fileList = list_files_in_directory(SAVE_PATH)
	
	# for each in fileList: 
		# var l_button = LOADBUTTON.instantiate()
		# l_button.text = str(each)
		# get_node("VBoxContainer").add_child(l_button)
		# l_button.pressed.connect(self.load_game.bind(each))
