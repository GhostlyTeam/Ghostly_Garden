extends Spatial

export var movement_speed : float = 12.0
export var VISIBLE_DISTANCE : float = 35.0
export var MAX_DISTANCE : float = 80.0

onready var nav_agent : NavigationAgent = $NavigationAgent
onready var player : KinematicBody = get_node("../../Player")

var movement_delta : float

func _ready():
	visible = false
	pass

func _physics_process(delta):
 
	nav_agent.set_target_location(player.global_translation)

	if nav_agent.distance_to_target() < MAX_DISTANCE:
		
		if nav_agent.distance_to_target() < VISIBLE_DISTANCE:
			visible = true
		
		movement_delta = movement_speed * delta
		
		var next_path_position : Vector3 = nav_agent.get_next_location()
		var current_agent_position : Vector3 = global_transform.origin
		var new_velocity : Vector3 = (next_path_position - current_agent_position).normalized() * movement_delta
		global_transform.origin = global_transform.origin.move_toward(global_transform.origin + new_velocity, movement_delta)


func kill():
	get_parent().respawn()
	queue_free()
	

