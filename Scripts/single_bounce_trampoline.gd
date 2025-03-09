extends CharacterBody2D

var active = false
@onready var startpos = self.position
var speed = 0
@export var velo = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if active:
		velocity.y = speed
		move_and_slide()
		velo.y = speed / 30
		speed = move_toward(speed, -100, 2 * delta * 60)
	
	if speed <= -50 and active:
		active = false
		wait(.3)
	
func trigger() -> void:
	if self.position == startpos:
		speed = 40
		active = true

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	self.position = Vector2(-10000, 0)

func _process(delta: float) -> void:
	if RespawnHandler.respawning > 0:
		self.position = startpos
		self.active = false
		speed = 0
		velo = Vector2.ZERO
		
