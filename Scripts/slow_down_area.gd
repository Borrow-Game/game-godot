extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("arrow"):
		body.slowdown = 0.06


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("arrow"):
		body.slowdown = 1
