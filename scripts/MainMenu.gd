extends Control

func _ready():
	pass

func _on_Start_pressed() -> void:
	get_tree().change_scene("res://scenes/Garden.tscn")

# Closes game
func _on_Exit_pressed() -> void:
	get_tree().quit()