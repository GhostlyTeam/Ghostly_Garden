extends Spatial
class_name Ghost

export var movement_speed : float = 10.0

onready var nav_agent : NavigationAgent = $NavigationAgent
onready var player : KinematicBody = get_node("../Player")

var movement_delta : float

func _ready():
	nav_agent.set_target_location(player.global_translation)

func _physics_process(delta):

	nav_agent.set_target_location(player.global_translation)
	movement_delta = movement_speed * delta
	var next_path_position : Vector3 = nav_agent.get_next_location()
	var current_agent_position : Vector3 = global_transform.origin
	var new_velocity : Vector3 = (next_path_position - current_agent_position).normalized() * movement_delta
	#nav_agent.set_velocity(new_velocity)
	global_transform.origin = global_transform.origin.move_toward(global_transform.origin + new_velocity, movement_delta)


func kill():
	$AnimationPlayer.play("Death")
	$Area/CollisionShape.disabled = true
	var err = get_tree().create_timer(2).connect("timeout", self, "respawn")
	if err:
		print(err)

func respawn():
	queue_free()
	pass

