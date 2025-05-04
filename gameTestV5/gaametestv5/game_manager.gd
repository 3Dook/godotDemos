extends Node2D
@onready var ball: Ball = $ball
@onready var ui: Control = $UI
@export var player_score = 0
@export var enemy_score = 0
# have a script to run options then have options one or two applied 
 
# Player Data should be here

func player_scored():
	print("player scored")
	player_score += 1
	ui.update_player(player_score)
	reset_gamestate()

func enemy_scored():
	print('enemy scored')
	enemy_score += 1
	ui.update_enemy(enemy_score)
	reset_gamestate()

func reset_gamestate():
	ball.start_ball()
