extends Node

var respawning = 0
var deathScene = preload('res://Scenes/death_scene.tscn')
func respawn() -> void:
	Input.start_joy_vibration(0, 0.8, 0.8, 0.2)
	HapticsHandler.shake(0.5, 1)
	
	var instance = deathScene.instantiate()
	instance.position = Vector2(300, 300)  # Adjust the position as needed
	add_child(instance)
	instance.playAnimation()
	wait(0.4, instance)

func wait(seconds: float, instance) -> void:
	await get_tree().create_timer(seconds).timeout
	respawning = 2
	await get_tree().create_timer(0.6).timeout
	instance.queue_free()

func _process(delta: float) -> void:
	if respawning > 0:
		respawning -= 1

#respawns can be initiated by calling RespawnHandler.respawn()
