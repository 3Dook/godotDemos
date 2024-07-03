extends CanvasLayer

var is_open = false
# Called when the node enters the scene tree for the first time.


@onready var day_label = $ColorRect/board/dayLabel
@onready var buy_score = $ColorRect/board/buyScore
@onready var day_timer = $dayTimer

# data to go through

var day: int = 1
var money: int = 100


func _ready():
	update_money(0)
	update_day(1)
	pass # Replace with function body.


func _process(_delta):
	if Input.is_action_just_pressed("helper"):
		if is_open:
			close()
		else:
			open()
			
func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false

func update_day(cycle: int):
	day_label.text = 'DAY: ' + str(cycle)
	
func update_money(change: int):
	money += change
	buy_score.text = str(money)	

func _on_day_timer_timeout():
	update_day(day + 1)
	day_timer.start()
