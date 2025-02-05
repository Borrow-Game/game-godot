extends CharacterBody2D


@export var SPEED = 100.0
@export var JUMP_VELOCITY = -240.0 /1.5
var x_acceleration = 40

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta


	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, x_acceleration / 2)
	else:
		velocity.x = move_toward(velocity.x , 0, x_acceleration)

	move_and_slide()
