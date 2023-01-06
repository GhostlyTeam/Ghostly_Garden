extends Spatial

const ghost_asset := preload("res://scenes/Ghost.tscn")


var rng

const MIN_TIME = 5.0
const MAX_TIME = 10.0

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	spawn()

func respawn():
	get_tree().create_timer(getRandomNumber(MIN_TIME, MAX_TIME)).connect("timeout", self, "spawn")

func spawn():
	var ghost := ghost_asset.instance()
	add_child(ghost)

func getRandomNumber(min_t, max_t):
	return rng.randf_range(min_t, max_t)


