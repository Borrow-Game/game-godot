extends Node2D

@export var active = true
var started = 0
func _process(delta: float) -> void:
	if active:
		if started == 0:
			$intro.playing = true
