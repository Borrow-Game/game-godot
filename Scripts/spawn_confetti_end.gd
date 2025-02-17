extends Area2D

var confetti_scene = preload('res://Scenes/confetti.tscn')

func _on_body_entered(body):
	if body.is_in_group("player"):  # Check if the player entered
		spawn_confetti()  # Set your confetti position
		wait(1, body)

func wait(seconds: float, body) -> void:
	await get_tree().create_timer(seconds).timeout
	RespawnHandler.respawn("conf")
	body.set_physics_process(false)

func spawn_confetti():
	var instance = confetti_scene.instantiate()
	instance.global_position = Vector2(3935, -16)  # Adjust the position as needed
	# Add to the main scene (not the Area2D)
	get_tree().current_scene.add_child(instance)
	
