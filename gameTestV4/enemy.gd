extends CharacterBody2D

const speed = 150

@export var player: Node2D
@onready var navigation_agent_2d := $NavigationAgent2D as NavigationAgent2D


func _physics_process(_delta: float) -> void:
	var dir = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	#var next_path_pos := navigation_agent_2d.get_next_path_position()
	#var dir := global_position.direction_to(next_path_pos)	
	velocity = dir * speed
	print(velocity)
	move_and_slide()


func makePath(target):
	print('target loaded')
	navigation_agent_2d.target_position = player.global_position
	#navigation_agent_2d.target_position = target
	print(navigation_agent_2d.target_position)

func testPlayer():
	print('testing playter global')
	navigation_agent_2d.target_position = player.global_position
	#navigation_agent_2d.target_position = target
	print(navigation_agent_2d.target_position)


func _on_timer_timeout():
	testPlayer()
