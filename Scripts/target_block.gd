extends StaticBody2D

# the target block will automatically trigger a function trigger() in the linked object when hit with an arrow
# to use target blocks link the block to the to be affected node and give that node a function trigger()

@export var triggered_note: Node

func _on_target_block_arrow_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("arrow"):
		triggered_note.trigger()
		Input.start_joy_vibration(0, 0.5, 0.5, 0.1)
