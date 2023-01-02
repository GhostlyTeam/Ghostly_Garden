extends Spatial
class_name Ghost

# Declare member variables here.
var position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# randomize()
	# var x_range = Vector2(100, 400)
	# var y_range = Vector2(100, 400)

	# var random_x = randi() % int(x_range[1]- x_range[0]) + 1 + x_range[0] 
	# var random_y =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
	# var random_pos = Vector2(random_x, random_y)

	# position=random_pos

func kill():
	$AnimationPlayer.play("Death")
	$Area/CollisionShape.disabled = true
	var err = get_tree().create_timer(2).connect("timeout", self, "respawn")
	if err:
		print(err)


func respawn():
	queue_free()
	pass
