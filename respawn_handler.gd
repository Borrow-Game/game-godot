extends Node

var respawning = 0

func respawn() -> void:
	respawning = 2
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		respawn()
	
	if respawning > 0:
		respawning -= 1


#respawns can be initiated by calling RespawnHandler.respawn()
