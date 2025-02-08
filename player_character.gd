extends CharacterBody2D

var arrow_scene = preload("res://arrow.tscn")
var aim_angle: float = 0


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
		velocity.x = move_toward(velocity.x, direction * SPEED, (x_acceleration / 2) * 60 * delta)
	else:
		velocity.x = move_toward(velocity.x , 0, x_acceleration  * 60 * delta)

	move_and_slide()
	
	if Input.is_action_pressed("shoot bow"):
		aim_angle = move_toward(aim_angle, 90, -2  * 60 * delta)
		$"indication-center".visible = true
	if Input.is_action_just_released("shoot bow"):
		if self.get_parent().get_node("arrows").get_child(0):
			self.get_parent().get_node("arrows").get_child(0).queue_free()
		shoot(delta, aim_angle)
		aim_angle = 0
		$"indication-center".visible = false
		
	
	$"indication-center".rotation_degrees=aim_angle
		

func shoot(delta: float, angle: float) ->void:
	var new_arrow = arrow_scene.instantiate()
	new_arrow.angle = aim_angle
	new_arrow.position = self.global_position
	self.get_parent().get_node("arrows").add_child(new_arrow)


	
	
