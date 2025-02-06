extends CharacterBody2D

const SPEED = 60.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 400.0
const DASH_DURATION = 0.2
const DASH_COOLDOWN = 0.5

var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
		
	if is_dashing:
		velocity = dash_direction * DASH_SPEED
		dash_timer -= delta
		
		if dash_timer <= 0:
			is_dashing = false
	else:
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
			start_dash()
	move_and_slide()
	
func start_dash() -> void:
	is_dashing = true
	dash_timer = DASH_DURATION
	dash_cooldown_timer = DASH_COOLDOWN

	dash_direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	if dash_direction == Vector2.ZERO:
		dash_direction = Vector2(1 if Input.get_action_strength("ui_right") > 0 else -1, 0)
		
		
