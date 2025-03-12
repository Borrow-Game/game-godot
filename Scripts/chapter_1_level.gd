extends Node2D

@export var Camera: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HapticsHandler.camera = Camera
	$ParallaxBackground.offset.x = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$CanvasLayer/ParallaxBackground.offset.y = Camera.global_position.y
	pass
	
