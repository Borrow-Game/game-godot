extends CharacterBody2D

@export var angle = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity = Vector2.from_angle(deg_to_rad(angle))  * 10
	move_and_collide(velocity)
	angle += 1
	
