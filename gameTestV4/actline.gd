extends Line2D


func setColor(index, col: Color) -> void:
	print("setting color", col)
	print(gradient.get_color(1))
	#gradient.set_color(0, col)


func add_color_point(pos: Vector2, col: Color) -> void:
	add_point(pos)
	gradient.add_point(1.0, col)
	await get_tree().process_frame
	calculate_gradients()

func calculate_gradients() -> void:
	var total: float = 0
	var distances: Array[float] = [0.0]
	# calculate point positions/lengths
	for i in range(1, points.size()):
		var distance := points[i-1].distance_to(points[i])
		distances.append(distance)
		total += distance

	# replace gradient offsets
	var this_distance: float = 0.0
	for i in range(gradient.offsets.size()):
		this_distance += distances[i]
		gradient.offsets[i] = this_distance / total
