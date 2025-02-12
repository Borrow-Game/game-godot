extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D/CollisionShape2D.scale = Vector2(abs(self.limit_left - self.limit_right), abs(self.limit_top- self.limit_bottom))
	$Area2D/CollisionShape2D.global_position = self.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_current():
		self.position = HapticsHandler.camera_pos
		print(HapticsHandler.camera_pos)




func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		
		self.make_current()
		HapticsHandler.camera = self
		
	
