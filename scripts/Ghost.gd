extends KinematicBody

onready var nav = $"../NavMeshInst" as Navigation
onready var player = $"../Player" as KinematicBody


var path = []
var current_node = 0
var speed = 2


func _ready():
	# Generate path to the player
	#update_path(player.global_transform.origin)
	pass
	


func _physics_process(delta):
	update_path(player.global_transform.origin)
	if current_node < path.size():
		var direction: Vector3 = path[current_node] - global_transform.origin
		if direction.length() < 1:
			current_node += 1
		else:
			move_and_slide(direction.normalized() * speed)

func update_path(target_position):
	path = nav.map_get_path(global_transform.origin, target_position)
	

	
	
	
