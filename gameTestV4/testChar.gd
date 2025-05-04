extends CharacterBody2D

const speed = 150

@export var player: Node2D
@onready var navigation_agent_2d := $NavigationAgent2D as NavigationAgent2D

@export var setTarget: Vector2
@onready var actionQ = []

#const ACTLINE = preload("res://actline.tscn")
#var actLine;
@onready var actline = $Actline

# This is a preload ability - 

var bullet_ab1 = preload("res://egg_blast.tscn")

func _ready():
	setTarget = self.global_position
	#actLine = ACTLINE.instantiate()
	#self.add_child(actLine)

func _physics_process(_delta: float) -> void:
	#var dir = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	##var next_path_pos := navigation_agent_2d.get_next_path_position()
	##var dir := global_position.direction_to(next_path_pos)	
	#velocity = dir * speed
	#move_and_slide()
	
	if !actionQ.is_empty():
		var dir = to_local(navigation_agent_2d.get_next_path_position()).normalized()
		#var next_path_pos := navigation_agent_2d.get_next_path_position()
		#var dir := global_position.direction_to(next_path_pos)	
		velocity = dir * speed
		showQline()
		move_and_slide()
	
		if (abs(setTarget.y - position.y)) < 10 and (abs(setTarget.x - position.x)) < 10:
			print("Q position is at -", position, "and Q target position is at ", setTarget)
			actionQ.pop_front()
			actline.clear_points()
			if !actionQ.is_empty():
				# reset the move position action acgain.
				actline.clear_points()
				makePath(actionQ.front())
				
func makePath(target):
	setTarget = target
	#navigation_agent_2d.target_position = player.global_position
	navigation_agent_2d.target_position = target
	print(navigation_agent_2d.target_position)

func runPlayer():
	navigation_agent_2d.target_position = setTarget
	#navigation_agent_2d.target_position = target
	print(navigation_agent_2d.target_position)

func queueMove(target):
	if actionQ.is_empty():
		actionQ.append(target)
		makePath(target)
	else:
		actionQ.append(target)

func forceMove(target):
	actionQ.clear()
	queueMove(target)

func _on_timer_timeout():
	runPlayer()

func showQline():
	# Set the colors 
	# Set the end and start points - Start point is on character position
	# throw it on the line
	#print("------ POSITON TO ACTION ACT QUEUE")
	#print(position)
	#print(actionQ)
	#actline.set_point_position(0, Vector2(333, 400))
	actline.clear_points()

	actline.add_point(to_local(position))
		
	for i in actionQ.size():
		# add colors for the next move 
		# change colors if the action queue haas other stuff to do - acctack etc
		actline.add_point(to_local(actionQ[i]))
		# work on color and making it look nice later
		#if i > 1:
			#actline.setColor(i, Color(255, 0, 0))
			#
