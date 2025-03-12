extends Area2D

var active = false
var player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SubViewport.size = Vector2(self.scale.x * 64, self.scale.y * 32)
	
	$SubViewport/GPUParticles2D.process_material.emission_box_extents.y= self.scale.y * 16
	$SubViewport/GPUParticles2D.position.y = self.scale.y * 32 / 2 
	$SubViewport/GPUParticles2D.amount = 140 * self.scale.y
	$CollisionShape2D.scale = self.scale
	self.scale = Vector2.ONE
	#$SubViewport/MeshInstance2D.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if RespawnHandler.respawning > 0:
		active = false
	
	if active:
		
		if self.rotation_degrees == 0:
			player.fan_boost = Vector2(move_toward(player.fan_boost.x, 60, 70 * delta), 0)
		if round(self.rotation_degrees) == 180:
			player.fan_boost = Vector2(move_toward(player.fan_boost.x, -60, 70 * delta), 0)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		active = true
		player = body
		player.interacting_fans += 1
			

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		active = false
		player.interacting_fans -= 1
		
