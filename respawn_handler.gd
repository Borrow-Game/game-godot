extends Node

var respawning = 0

func respawn() -> void:
	respawning = 2
	
func _process(delta: float) -> void:

	
	if respawning > 0:
		respawning -= 1


#respawns can be initiated by calling RespawnHandler.respawn()
