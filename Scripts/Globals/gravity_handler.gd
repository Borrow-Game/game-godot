extends Node

var gravity = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_gravity(grav: int) -> void:
	ProjectSettings.set_setting("physics/2d/default_gravity_vector", Vector2(0, grav))
	gravity = grav
	print(ProjectSettings.get_setting("physics/2d/default_gravity_vector"))
