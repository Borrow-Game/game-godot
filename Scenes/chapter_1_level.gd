extends Node2D

@export var Camera: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HapticsHandler.camera = Camera


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
