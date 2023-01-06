extends Area

# Camera Shake Reduction Variable
export var shake_reduction_rate := 1.0

# Coordenates for shaking
export var max_x := 8.0
export var max_y := 8.0
export var max_z := 4.0

# Type of Shake - Noise
export var noise : OpenSimplexNoise
export var noise_speed := 50.0 #Shaking speed

var shake := 0.0
var time := 0.0

onready var camera_node := get_parent().get_child(1)

onready var initial_rotation := camera_node.rotation_degrees as Vector3

# Shaking
func _process(delta):
	time += delta
	shake = max(shake - delta * shake_reduction_rate, 0.0)
	
	camera_node.rotation_degrees.x = initial_rotation.x + max_x * _shake_intensity() * get_noise_from_seed(0)
	camera_node.rotation_degrees.y = initial_rotation.y + max_y * _shake_intensity() * get_noise_from_seed(1)
	camera_node.rotation_degrees.z = initial_rotation.z + max_z * _shake_intensity() * get_noise_from_seed(2)

# Function to increase shake intensity
func _increase_shake(shake_amount : float):
	shake = clamp(shake + shake_amount, 0.0, 1.0)

func _shake_intensity() -> float:
	return shake * shake

# Different seeds can change the values of the shaking (x, y, z)
func get_noise_from_seed(_seed : int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)
