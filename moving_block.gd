extends StaticBody2D

@export var aim_position: Vector2 = Vector2(0, 0)
@export var move_time: float = 1

@onready var start_position = self.position

var task = "idle" #idle: nothing to move, moving_to: moving to aim_position
var deltas_count = 0 #used to determine when th time has passed

func trigger() -> void:
	task = "moving_to"
	deltas_count = 0
	
func _physics_process(delta: float) -> void:
	if task == "moving_to":
		if delta + deltas_count < move_time:
			var distance = Vector2(aim_position-start_position)
			self.position += Vector2(delta/move_time * distance.x,delta/move_time * distance.y)
			deltas_count += delta
		else:
			self.position = aim_position
			task = "idle"
		
	
