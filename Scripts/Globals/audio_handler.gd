extends Node

var c
var audio_controller = preload("res://Scenes/audio_controller.tscn")

func _ready() -> void:
	if self.get_parent().get_node("scene"):
		c = audio_controller.instantiate()
		self.get_parent().get_node("scene").add_child(c)

func play(player: String) -> void:
	for i in c.get_children():
		i.active = false
		
	c.get_node(player).active = true
