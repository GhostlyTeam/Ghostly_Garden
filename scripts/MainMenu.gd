extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# warning-ignore:return_value_discarded
func _on_Start_pressed() -> void:
	get_tree().change_scene("res://scenes/Garden.tscn")

# Credits Meni
func _on_Credits_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")

# Closes game
func _on_Exit_pressed() -> void:
	get_tree().quit()


