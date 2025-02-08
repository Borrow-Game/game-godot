extends MeshInstance2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if RespawnHandler.respawning > 0:
		reset()
	pass

func trigger() -> void:
	self.modulate = Color("red")

func reset() -> void:
	self.modulate = Color8(255, 255, 255, 255)
