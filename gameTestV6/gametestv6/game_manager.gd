extends Node2D

const CARD = preload("res://card.tscn")
@onready var h_box_container: HBoxContainer = $HBoxContainer

@export var card_list = []
@export var on_play_list = []
@export var hand_list = []
@export var SEED = 12345
@export var MAX_HAND_SIZE = 13



func _ready() -> void:
	full_reset()

func full_reset():
	seed(SEED)
	make_deck()
	shuffle_hand()
	show_hand()

func show_hand():
	for n in h_box_container.get_children():
		h_box_container.remove_child(n)

	for i in hand_list:
		h_box_container.add_child(i)

func make_deck():
	for i in range(13):
		var Temp = CARD.instantiate()
		var blah = {
			"value": i + 1,
			"suit": "spade",
			"card_ref": i
		}
		Temp.set_up(blah)
		card_list.append(Temp)

func shuffle_hand():
	on_play_list = card_list.duplicate()
	on_play_list.shuffle()
	for i in range(MAX_HAND_SIZE):
		hand_list.append(on_play_list.pop_front())

func fill_hand():
	print('hand size is ', hand_list.size())
	for i in range(hand_list.size(), 5):
		if (on_play_list.size() > 0):
			hand_list.append(on_play_list.pop_front())

func discard_clicked_cards():
	
	hand_list = hand_list.filter(func(i): return !i.clicked == true)
	fill_hand()
	show_hand()
	

func _on_ui_pressed_play() -> void:
	print('playing  = need to calcualte card hand ')


func _on_ui_pressed_discard() -> void:
	discard_clicked_cards()
