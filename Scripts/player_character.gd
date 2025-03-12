extends CharacterBody2D

var is_on_platform = false
var platform: Node
@export var floor_buffer = Vector2.ZERO
var arrow_scene = preload("res://Scenes/arrow.tscn")
var aim_angle: float = 0
var arrow_direction = 1
@export var floor_buffer_active = false

@export var fan_boost = Vector2.ZERO
@export var interacting_fans = 0

@export var SPEED: float = 110.0
@export var JUMP_VELOCITY: float = -240.0 / 1.45
var x_acceleration: float = 40
@onready var character_texture: Sprite2D = $character_texture

@onready var startpoint = self.position

# DASH VARIABLES
@export var DASH_SPEED: float = 10.0
@export var DASH_DURATION: float = 0.1
var dashing: bool = false
var dash_timer: float = 0.0
var dash_available: bool = true
var dash_velocity: Vector2 = Vector2(0,0)
var dash_direction = Vector2(0,0)
var post_dash_velocity = Vector2(0, 0)

func _physics_process(delta: float) -> void:
	if interacting_fans == 0:
		if Input.get_axis("ui_left", "ui_right") < 0.1 and fan_boost.x > 0:
			fan_boost = Vector2(move_toward(fan_boost.x, 00, 200 * delta), 0)
		if Input.get_axis("ui_left", "ui_right") > 0.1 and fan_boost.x < 0:
			fan_boost = Vector2(move_toward(fan_boost.x, 00, 200 * delta), 0)
	
	HapticsHandler.camera_pos = self.position
	
	if Input.get_axis("left", "right") < 0:
		arrow_direction = -1
		character_texture.flip_h = true

	elif Input.get_axis("left", "right") > 0:
		arrow_direction = 1
		character_texture.flip_h = false

	# Check for dash input.
	# (Make sure you have defined "dash" in your Input Map.)
	if Input.is_action_just_pressed("dash") and dash_available:
		velocity = Vector2.ZERO
		floor_buffer = Vector2.ZERO
		floor_buffer_active = false
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
		if dash_direction == Vector2(0, 0):
			dash_direction.x = sign(velocity.x) if velocity.x != 0 else 1
		dash_direction = dash_direction.floor().normalized()

		dash_velocity = dash_direction * DASH_SPEED * 60 * delta
		dashing = true
		dash_timer = DASH_DURATION
		dash_available = false
		return

	# If currently dashing, count down the dash timer and move.
	if dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			dashing = false
			if dash_velocity.y > 0:
				post_dash_velocity = dash_velocity
		floor_buffer_active = false
		move_and_collide(dash_velocity)
	if post_dash_velocity != Vector2(0, 0):
		post_dash_velocity =  apply_post_dash_velocity(post_dash_velocity, delta)

	
	# Normal movement (only executed if not dashing).
	if not is_on_floor():
		velocity += get_gravity() * delta * GravityHandler.gravity

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY * GravityHandler.gravity

	var direction := Input.get_axis("left", "right")
	if direction and abs(velocity.x) < SPEED:
		velocity.x = move_toward(velocity.x, direction * SPEED, (x_acceleration / 2) * 60 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, x_acceleration * 60 * delta)
	floor_buffer.x = move_toward(floor_buffer.x, 0, 1 * delta)
	floor_buffer.y = move_toward(floor_buffer.y, 0, 1 * delta)
	
	if (floor_buffer.x < 0 and Input.get_axis("left", "right") > 0) or (floor_buffer.x > 0 and Input.get_axis("left", "right") < 0):
		floor_buffer.x = move_toward(floor_buffer.x, 0, 2 * delta)
		floor_buffer.y = move_toward(floor_buffer.y, 0, 2 * delta)

	if abs(floor_buffer.x) <= .3 and abs(floor_buffer.y) <= .3:
		floor_buffer_active = false
	move_and_slide()
	move_and_collide(floor_buffer)
		# Reset dash availability when on the ground.
	if is_on_floor():
		dash_available = true

	# Bow aiming and shooting code (unchanged)
	if Input.is_action_pressed("shoot bow") and GravityHandler.gravity == 1:
		aim_angle = move_toward(aim_angle, -70, 2  * 60 * delta)
		
		$"indication-center".visible = true
	elif Input.is_action_pressed("shoot bow") and GravityHandler.gravity == -1:
		aim_angle = move_toward(aim_angle, 70, 2  * 60 * delta)
		
		$"indication-center".visible = true
	else:
		$"indication-center".visible = false
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
	
	var old_pos = self.position
	move_and_collide(fan_boost * delta)
	if floor(self.position * 100) == floor(old_pos * 100) and fan_boost != Vector2.ZERO:
		fan_boost = Vector2.ZERO
	
func _process(delta: float) -> void:
	if RespawnHandler.respawning > 0:
		reset()
		
	if GravityHandler.gravity == -1:
		$character_texture.flip_v = true
		self.up_direction = Vector2(0, 1)
	else:
		$character_texture.flip_v = false
		self.up_direction = Vector2(0, -1)


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
	self.set_physics_process(true)
	floor_buffer = Vector2.ZERO
	floor_buffer_active = false
	post_dash_velocity = Vector2.ZERO
	fan_boost = Vector2.ZERO 


func _on_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("mplatform") or body.is_in_group("tramp"):

		floor_buffer_active = true
		is_on_platform = false
		floor_buffer = body.velo
		if Input.is_action_pressed("ui_accept") and floor_buffer.y > 0:
			floor_buffer.y = 0
			velocity.y = JUMP_VELOCITY
			if floor_buffer.x == 0:
				floor_buffer_active = false

func _on_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("cmplatform") or body.is_in_group("tramp"):
		body.trigger()
	
func apply_post_dash_velocity(ve, delt) -> Vector2:
	var initial_position = position
	move_and_collide(ve)
	var displacement = position - initial_position
	if displacement.y < 0:
		displacement.y = 0
	if (ve.x < 0 and displacement.x > 0) or (ve.x > 0 and displacement.x < 0):
		displacement.x = 0
	if displacement.x / abs(displacement.x) != ceil(dash_direction.x):
		displacement.x = 0
	return displacement
	
	

		
