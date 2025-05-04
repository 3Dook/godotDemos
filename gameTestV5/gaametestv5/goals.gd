extends Area2D

signal point_scored

func _on_goals_body_entered(body: Node2D) -> void:
	if body is Ball:
		point_scored.emit()
		# emit signal up to remove ball - and add to score
