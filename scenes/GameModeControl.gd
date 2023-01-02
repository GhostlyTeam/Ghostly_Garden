extends Control


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Win" or anim_name == "Died":
		get_tree().change_scene("res://scenes/MainMenu.tscn")
