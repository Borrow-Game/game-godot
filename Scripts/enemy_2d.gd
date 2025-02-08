extends CharacterBody2D
@onready var startposition = self.position
@export  var goal_position = Vector2()
@export var speed = 10

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("arrow"):
		body.queue_free()
		Input.start_joy_vibration(0, 0.1, 0.1, 0.2)
		queue_free()
	if body.is_in_group("player"):
		RespawnHandler.respawn()
		

		
func _physics_process(delta: float) -> void:

	if RespawnHandler.respawning > 0:
		self.position = startposition
		speed = abs(speed)
		
	
	
	velocity.x = speed
	
	if self.position.x >= goal_position.x :
		speed  = abs(speed) * -1
		
	
	if self.position.x <=startposition.x :
		speed  = abs(speed)
	move_and_slide()	
		
