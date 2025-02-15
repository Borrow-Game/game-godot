extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	print("Resume button pressed")
	
	# Find the pause menu parent and remove it
	var pause_menu = get_parent().get_parent()
	if pause_menu:
		pause_menu.queue_free()  # Remove the entire pause menu
