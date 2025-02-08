extends CharacterBody2D

@export var angle = 0

var active = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if active:
		velocity = Vector2.from_angle(deg_to_rad(angle))  * 10
		move_and_collide(velocity)
		angle += 1  * 60 * delta
	
		if RespawnHandler.respawning > 0:
			reset()
		
func reset() -> void:
	self.queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("wall"):
		active = false
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		self.set_collision_layer_value(1, true)
