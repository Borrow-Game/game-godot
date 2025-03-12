extends Node2D

@export var speed = 1.0

func _process(delta: float) -> void:
	$container.rotation_degrees += speed
	for i in $container.get_children():
		i.rotation = 0 - $container.rotation
		i.scale = Vector2(1 / self.scale.x, 1 / self.scale.y)
