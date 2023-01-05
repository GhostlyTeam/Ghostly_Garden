extends KinematicBody

export (float) var REFRESH_TIME = 2.0 # 2 second 
export (float) var DEATH_TIME = 3.0 # 5 second 

# Player Constants
const GRAVITY = -100
const JUMP_SPEED = 50
const ACCEL = 4.5
const MAX_FLASHLIGHT = 100
const MAX_HEALTH = 100
const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40
const SHAKE_CAMERA_STRENGTH: float = 60.0

var health = 100
var flashlight = 100

# Camera Shake
var camera_shake_intensity = 0.0
var camera_shake_duration = 0.0



# Player Variables
var vel = Vector3()
var dir = Vector3()
var camera
var player_speed = 20
var rotation_helper
var MOUSE_SENSITIVITY = 0.05

var gui
var gamemodeElemsAnim
var gamemodeElemsDamageAnim

# Items
var isGoldBarCollected = false
var isRubyCollected = false
var isPearlCollected = false

# Input ready
var isPlayerReceivingInput = true

# Ghosts
var ghost_count = 0

func _ready():
	camera = $Rotation_Helper/Camera
	rotation_helper = $Rotation_Helper

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	gui = get_node("../GUI")
	gamemodeElemsAnim = get_node("../GameModeElems/AnimationPlayer")
	gamemodeElemsDamageAnim = get_node("../GameModeElems/DamageAnimation")
	
	gui.toggle_gold_bar(false)
	gui.toggle_ruby(false)
	gui.toggle_pearl(false)
	gui.set_health(100)
	gui.set_flashlight(100)
	$Rotation_Helper/Flashlight.light_energy = 5

func _process(delta):
	if isPlayerReceivingInput:

		if flashlight < 100:
			var perc = delta / REFRESH_TIME
			flashlight += (perc * MAX_FLASHLIGHT)
			if flashlight > 100:
				flashlight = MAX_FLASHLIGHT
			gui.set_flashlight(flashlight)

		var areas = $Rotation_Helper/DeadCollision.get_overlapping_areas()
		var isGhostDetected = false
		var perc_death = delta / DEATH_TIME
		for area in areas:
			if area.is_in_group("ghost"):
				isGhostDetected = true
				$Rotation_Helper/DeadCollision/CamShake.shake_cam() # Camera Shakes
				health -= (perc_death * MAX_HEALTH)
				if health <= 0:
					health = 0
					gui.set_health(health)
					isPlayerReceivingInput = false
					gui.visible = false
					gamemodeElemsAnim.play("Died")
				
		if not isGhostDetected and health < 100:
			health += (perc_death * MAX_HEALTH)
			if health > 100:
				health = 100

		gui.set_health(health)


func _physics_process(delta):
	if isPlayerReceivingInput:
		process_input(delta)
		process_movement(delta)

# warning-ignore:return_value_discarded
func process_input(_delta):

	# ----------------------------------
	# Walking
	dir = Vector3()
	var cam_xform = camera.get_global_transform()

	var input_movement_vector = Vector2()

	if Input.is_action_pressed("movement_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("movement_backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("movement_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("movement_right"):
		input_movement_vector.x += 1
	if Input.is_action_just_pressed("movement_run"):
		player_speed += 15
	if Input.is_action_just_released("movement_run"):
		player_speed -= 15

	input_movement_vector = input_movement_vector.normalized()

	# Basis vectors are already normalized.
	dir += -cam_xform.basis.z * input_movement_vector.y
	dir += cam_xform.basis.x * input_movement_vector.x

	# Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("movement_jump"):
			vel.y = JUMP_SPEED

	if Input.is_action_just_pressed("flashlight_click"):
		if flashlight >= 100:
			flashlight = 0
			gui.set_flashlight(0)
			$Rotation_Helper/Flashlight/FlashlightPlayer.play("Flashlight")
			var areas = $Rotation_Helper/FlashlightCollision.get_overlapping_areas()
			for body in areas:
				if body.is_in_group("ghost"):
					body.kill()
	
	if Input.is_action_just_pressed("interaction"):
		var areas = $Rotation_Helper/InteractionCollision.get_overlapping_areas()
		for area in areas:	
			if area.get_class() == "CollectibleItem":
				if area.get_collectible_type() == "GoldBar":
					gui.toggle_gold_bar(true)
					isGoldBarCollected = true
				elif area.get_collectible_type() == "Ruby":
					gui.toggle_ruby(true)
					isRubyCollected = true
				elif area.get_collectible_type() == "Pearl":
					gui.toggle_pearl(true)
					isPearlCollected = true
		if isGoldBarCollected and isRubyCollected and isPearlCollected:
			isPlayerReceivingInput = false
			gui.visible = false
			gamemodeElemsAnim.play("Win")

func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * GRAVITY

	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= player_speed

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))

func _input(event):
	
	if isPlayerReceivingInput and event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot


func _on_DeadCollision_area_entered(area:Area):
	if area.is_in_group("ghost"):
		ghost_count += 1
		if ghost_count == 1:
			gamemodeElemsDamageAnim.stop()
			gamemodeElemsDamageAnim.play("DamageStart")



func _on_DeadCollision_area_exited(area:Area):
	if area.is_in_group("ghost"):
		ghost_count -= 1
		if ghost_count == 0:
			gamemodeElemsDamageAnim.play("DamageStart",-1, -1.0, false)


