extends StaticBody2D

@export var type: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if type == -1:
		$MeshInstance2D.modulate = Color("c23e47")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if FlipswitchHandler.active == type:
		self.set_collision_layer_value(1, true)
		self.set_collision_mask_value(1, true)
		$MeshInstance2D.self_modulate = Color("ffffff")
	else:
		self.set_collision_layer_value(1, false)
		self.set_collision_mask_value(1, false)
		$MeshInstance2D.self_modulate = Color("404040")
		
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("arrow"):
		FlipswitchHandler.active = type
		body.queue_free()
