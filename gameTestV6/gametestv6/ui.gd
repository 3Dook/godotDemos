extends CanvasLayer
@onready var score: Label = $Score
@onready var money: Label = $Money

signal pressed_play
signal pressed_discard

func _on_play_pressed() -> void:
	# send a signal that a play is being made.
	pressed_play.emit()

func _on_discard_pressed() -> void:
	pressed_discard.emit()

func update_score(num):
	score.text = "Score: " + str(num)

func updaate_money(num):
	money.text = "$: " + str(num)
