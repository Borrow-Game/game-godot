extends Node2D
var arrow_scene = preload("res://arrow.tscn")
var aim_angle = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot bow"):
		var new_arrow = arrow_scene.instantiate()
		new_arrow.angle = aim_angle
		new_arrow.position = Vector2(0, 96)
		self.add_child(new_arrow)
	
	if Input.get_axis("ui_up", "ui_down"):
		aim_angle += Input.get_axis("ui_up", "ui_down")
		
		

	
