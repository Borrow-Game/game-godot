extends Node

var respawning = 0

func respawn() -> void:
	respawning = 2
	Input.start_joy_vibration(0, 0.8, 0.8, 0.2)
	HapticsHandler.shake(0.5, 1)
	
func _process(delta: float) -> void:

	
	if respawning > 0:
		respawning -= 1


#respawns can be initiated by calling RespawnHandler.respawn()
