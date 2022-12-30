extends Spatial

export(PackedScene) var Ghost
onready var timer = $Timer

export var num_ghosts = 5
export var second_between_spawns = 3

# Tracking remaining ghosts
var ghosts_remaining_to_spawn



func _ready():
	ghosts_remaining_to_spawn = num_ghosts
	timer.wait_time = second_between_spawns
	timer.start()

func _on_Timer_timeout():
	if ghosts_remaining_to_spawn:
		# Spawns Ghost
		print(ghosts_remaining_to_spawn)
		var ghost = Ghost.instance()
		var scene_root = get_parent()
		scene_root.add_child(ghost)
		ghosts_remaining_to_spawn -= 1
