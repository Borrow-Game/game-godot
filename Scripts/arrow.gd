extends CharacterBody2D

@export var angle = 1

var active = true
var speed = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	speed = -20 /  angle + 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if active:
		velocity = Vector2.from_angle(deg_to_rad(angle))  * 10
		move_and_collide(velocity)
		if angle < 90:
		
			angle += speed  * 60 * delta
	
		if RespawnHandler.respawning > 0:
			reset()
	self.rotation = deg_to_rad(angle)
	
func reset() -> void:
	self.queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("wall"):
		active = false
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		self.set_collision_layer_value(1, true)
