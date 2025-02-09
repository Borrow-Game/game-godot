extends Node2D # Replace with your main node type (e.g., Sprite, Node, etc.)

@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer

func playAnimation():
	animation_player.play("death")
