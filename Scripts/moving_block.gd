extends StaticBody2D

@export var aim_position: Vector2 = Vector2(0, 0)
@export var move_time: float = 1

@onready var start_position = self.global_position

var task = "idle" #idle: nothing to move, moving_to: moving to aim_position
var deltas_count = 0 #used to determine when th time has passed

func trigger() -> void:
	if task == "idle":
		task = "moving_to"
		deltas_count = 0
	
func _physics_process(delta: float) -> void:
	if task == "moving_to":
		if delta + deltas_count < move_time:
			Input.start_joy_vibration(0, 0.1, 0.1, move_time)
			var distance = Vector2(aim_position-start_position)
			self.position += Vector2(delta/move_time * distance.x,delta/move_time * distance.y)
			deltas_count += delta
			print(distance)
		else:
			self.position = aim_position
			task = "finished"
			Input.start_joy_vibration(0, 0.6, 0.6, 0.2)
		


func reset() -> void: # gets triggerd if respawn
	self.global_position = start_position
	task = "idle" #idle: nothing to move, moving_to: moving to aim_position
	deltas_count = 0 #used to determine when th time has passed
	
func _process(delta: float) -> void:
	if RespawnHandler.respawning > 0:
		reset()
