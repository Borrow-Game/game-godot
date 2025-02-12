extends Area2D


func _process(delta: float) -> void:
	if $Camera2D.is_current():
		$Camera2D.global_position = HapticsHandler.camera_pos
		
		print(HapticsHandler.camera_pos)




func _ready() -> void:
	$Camera2D.limit_left = self.position.x - (self.scale.x - 1) / 2
	$Camera2D.limit_right = self.position.x + (self.scale.x - 1) / 2
	$Camera2D.limit_top = self.position.y - (self.scale.y - 1) / 2
	$Camera2D.limit_bottom = self.position.y + (self.scale.y - 1) / 2
	$Area2D.global_scale = self.scale - Vector2(20, 20)

func _on_body_entered(body: Node2D) -> void:
		
	if body.is_in_group("player"):
		
		$Camera2D.make_current()
		HapticsHandler.camera = $Camera2D
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		
		$Camera2D.make_current()
		HapticsHandler.camera = $Camera2D
