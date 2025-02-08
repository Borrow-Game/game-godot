extends Node


var fulscreen =   true



func _input(event):
	if event.is_action_pressed("fullscreen") and fulscreen == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		fulscreen = true
	
	elif event.is_action_pressed("fullscreen") and fulscreen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		 
		fulscreen = false

		
	
				
			
				
