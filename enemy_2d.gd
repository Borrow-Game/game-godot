extends CharacterBody2D
@onready var startposition = self.position
@export  var goal_position = Vector2()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("arrow"):
		queue_free()
	if body.is_in_group("player"):
		RespawnHandler.respawn()
		
var speed = 10
		
func _physics_process(delta: float) -> void:

	
	
	
	velocity.x = speed
	
	if self.position.x >= goal_position.x :
		speed  = -10
		
	
	if self.position.x <=startposition.x :
		speed  = 10
	move_and_slide()	
		
