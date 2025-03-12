extends Node2D

@export var active = false
var started = 0

@export var intro: AudioStream
@export var loop: AudioStream

func _ready() -> void:
	$intro.stream = intro
	$loop.stream = loop

func _process(delta: float) -> void:
	if active:
		if started == 0:
			$intro.play(0.0)
			started = 1
	else:
		$intro.playing = false
		$loop.playing = false
		started = 0

	


func _on_intro_finished() -> void:
	$loop.play()
