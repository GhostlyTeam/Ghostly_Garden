extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Goes back to main menu
func _on_Back_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
