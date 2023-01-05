extends Control

#Prepares set_is_paused variable
var is_paused = false setget set_is_paused

func _ready():
	#Game is not paused by default
	set_is_paused(false)
	
	
#Handless "Pause" input to pause the game
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		set_is_paused(not is_paused)
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
#Gets set_is_paused value to check if the game is paused or not
#Shows menu or not
func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

#If option "Continue" the game closes the Pause Screen
func _on_Continue_pressed():
	self.is_paused = false
	
func _on_Restart_pressed():
	self.is_paused = false
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	
func _on_MainMenu_pressed():
	self.is_paused = false
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	
func _on_ExitGame_pressed():
	self.is_paused = false
	get_tree().quit()


