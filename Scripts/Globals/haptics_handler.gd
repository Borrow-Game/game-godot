extends Node

var shake_deltas
var shaking = false

var shake_time = 1
var shake_strength = 1

var camera
var rnd = RandomNumberGenerator.new()
# detects if there is a camera specified
func _ready() -> void:
	if self.get_parent().get_node("scene"):
		camera = self.get_parent().get_node("scene").Camera 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shaking:
		if camera:
			camera.offset = Vector2(rnd.randf_range(-shake_strength, shake_strength), rnd.randf_range(-shake_strength, shake_strength))
		shake_deltas += delta
		
		if shake_deltas >= shake_time:
			shaking = false
			if camera:
				camera.offset = Vector2.ZERO
			

func shake(time, strength):
	shake_deltas = 0
	shake_time = time
	shake_strength = strength
	shaking = true
	
