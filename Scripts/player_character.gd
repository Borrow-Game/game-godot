extends CharacterBody2D

var arrow_scene = preload("res://Scenes/arrow.tscn")
var aim_angle: float = 0
var arrow_direction = 1

@export var SPEED: float = 100.0
@export var JUMP_VELOCITY: float = -240.0 / 1.45
var x_acceleration: float = 40

@onready var startpoint = self.position

# DASH VARIABLES
@export var DASH_SPEED: float = 10.0
@export var DASH_DURATION: float = 0.1
var dashing: bool = false
var dash_timer: float = 0.0
var dash_available: bool = true
var dash_velocity: Vector2 = Vector2(0,0)
var dash_direction = Vector2(0,0)

func _physics_process(delta: float) -> void:

	if Input.get_axis("left", "right") < 0:
		arrow_direction = -1
	elif Input.get_axis("left", "right") > 0:
		arrow_direction = 1


	# Check for dash input.
	# (Make sure you have defined "dash" in your Input Map.)
	if Input.is_action_just_pressed("dash") and dash_available:
		Input.start_joy_vibration(0, 0.1, 0.1, 0.2)
		dash_direction = Vector2(
			(Input.get_action_strength("right")) - (Input.get_action_strength("left")),
			(Input.get_action_strength("down")) - (Input.get_action_strength("up"))
		)
		if dash_direction.x < 0:
			dash_direction.x = -1
		elif dash_direction.x > 0:
			dash_direction.x = 1
		if dash_direction.y < 0:
			dash_direction.y = -1
		elif dash_direction.y > 0:
			dash_direction.y = 1
		# If no directional input, default to the current horizontal facing.
		if dash_direction == Vector2.ZERO:
			dash_direction.x = sign(velocity.x) if velocity.x != 0 else 1
		dash_direction = dash_direction.floor().normalized()
		print(dash_direction)
		
		dash_velocity = dash_direction * DASH_SPEED
		dashing = true
		dash_timer = DASH_DURATION
		dash_available = false
		return

	# If currently dashing, count down the dash timer and move.
	if dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			dashing = false
			velocity = Vector2(0, 0)
		move_and_collide(dash_velocity)
		return

	# Normal movement (only executed if not dashing).
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, (x_acceleration / 2) * 60 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, x_acceleration * 60 * delta)
	move_and_slide()
		# Reset dash availability when on the ground.
	if is_on_floor():
		dash_available = true
	# Bow aiming and shooting code (unchanged)
	if Input.is_action_pressed("shoot bow"):
		aim_angle = move_toward(aim_angle, -70, 2  * 60 * delta)
		
		$"indication-center".visible = true
	if Input.is_action_just_released("shoot bow"):
		if self.get_parent().get_node("arrows").get_child(0):
			self.get_parent().get_node("arrows").get_child(0).queue_free()
		shoot(delta, aim_angle)
		aim_angle = 0
		$"indication-center".visible = false
	if arrow_direction == 1:
		$"indication-center".rotation_degrees=aim_angle
	else:
		$"indication-center".rotation_degrees=-179 - aim_angle
	
	if RespawnHandler.respawning > 0:
		reset()


func shoot(delta: float, angle: float) -> void:
	var new_arrow = arrow_scene.instantiate()
	if arrow_direction == 1:
		new_arrow.angle = angle - 1
	else:
		new_arrow.angle = -180 - angle
	new_arrow.direction = arrow_direction
	new_arrow.position = self.global_position
	self.get_parent().get_node("arrows").add_child(new_arrow)

	
func reset() -> void: # gets triggerd if respawn
	self.position = startpoint
