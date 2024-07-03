extends Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_released("left_click"):
		queue_free()
