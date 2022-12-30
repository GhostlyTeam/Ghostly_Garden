extends KinematicBody

export(PackedScene) var Ghost
onready var timer = $Timer

#onready var nav = $"../NavMeshInst" as Navigation
onready var agent : NavigationAgent = $NavigationAgent
#onready var player = $"../Player" as KinematicBody
onready var player : KinematicBody = $"../Player"

export var speed = 5

export var num_ghosts = 5
export var second_between_spawns = 3

# Tracking remaining ghosts
var ghosts_remaining_to_spawn



func _ready():
	
	print("Agent ",agent)
#	print("Nav: " ,nav)
	print("Player ",player)
	print("end")
	
	# Goes to Player Positon to attack him
	agent.set_target_location(player.transform.origin)
	
	ghosts_remaining_to_spawn = num_ghosts
	timer.wait_time = second_between_spawns
	timer.start()
	
func _physics_process(delta):
	# Gets the next position
	var next_pos = agent.get_next_location()
	# Work out the velocity
	var velocity = (next_pos - transform.origin).normalized() * speed * delta
	#print(velocity)
	# Move to position
	move_and_collide(velocity)
	
	

func _on_Timer_timeout():
	if ghosts_remaining_to_spawn:
		# Spawns Ghost
		print(ghosts_remaining_to_spawn)
		var ghost = Ghost.instance()
		var scene_root = get_parent()
		scene_root.add_child(ghost)
		ghosts_remaining_to_spawn -= 1
