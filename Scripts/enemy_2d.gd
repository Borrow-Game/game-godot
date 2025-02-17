extends CharacterBody2D
@onready var startposition = self.position
@export  var goal_position = Vector2()
@export var speed = 30
@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("arrow"):
		if body.active:
			body.queue_free()
			Input.start_joy_vibration(0, 0.1, 0.1, 0.2)
			disable()
	if body.is_in_group("player"):
		RespawnHandler.respawn("sped")
		body.set_physics_process(false)

func _physics_process(delta: float) -> void:
	velocity.x = speed
	
	if self.position.x >= goal_position.x :
		speed  = abs(speed) * -1
		sprite_2d.flip_h = true
		
	if self.position.x <=startposition.x :
		speed  = abs(speed)
		sprite_2d.flip_h = false
	move_and_slide()	

func disable() -> void:
	self.set_physics_process(false)
	self.visible = false
	self.position = Vector2(-99999, -99999)
	
func _process(delta: float) -> void:
		if RespawnHandler.respawning > 0:
			self.position = startposition
			speed = abs(speed)
			self.set_physics_process(true)
			self.visible = true
