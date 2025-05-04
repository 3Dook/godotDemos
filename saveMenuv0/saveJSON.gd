extends Button
# This script shows how to save data using the JSON file format.
# JSON is a widely used file format, but not all Godot types can be
# stored natively. For example, integers get converted into doubles,
# and to store Vector2 and other non-JSON types you need `var2str()`.

const SAVE_PATH = "user://save_v0.json"
@onready var player = $"../../../../Game/Player"



func save_game():
	print('saving gaame')
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	var save_data = {}
	
	save_data["playerPosition"] = [player.position.x,player.position.y ]

	print(save_data)
	var json =JSON.stringify(save_data)
	
	file.store_string(json)
	file.close()
	
func load_game():
	print("loading game")
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	
	var json = file.get_as_text()
	
	var save_data = JSON.parse_string(json)
	
	player.position.x = save_data["playerPosition"][0]
	player.position.y = save_data["playerPosition"][1]
	
	file.close()
