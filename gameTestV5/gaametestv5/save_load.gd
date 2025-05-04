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

func check_save_file():
	if FileAccess.file_exists(SAVE_PATH):
		print("Save file exists!")
		return true
	else:
		print("No save file found.")
		return false

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
	# contents_to_save.foo = save_data.foo << goes here
	
