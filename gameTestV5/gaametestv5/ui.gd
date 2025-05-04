extends Control

@onready var playerpts: Label = $Playerpts
@onready var enemy_pt: Label = $enemyPt
@onready var count_d: Label = $countD
@onready var timer: Timer = $Timer

func _ready() -> void:
	print("on ready for UI")
	var test = timer
	print(count_d)
	print(timer)
	
func update_player(pts):
	playerpts.text = str(pts)
	
func update_enemy(pts):
	enemy_pt.text = str(pts)

func count_down():
	print("starting")
	count_d.visible = true
	for i in range(3):
		count_d.text = str(3 - i)
		timer.start()
		await timer.timeout
	count_d.visible = false
	print('go')
	
