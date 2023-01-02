extends KinematicBody

# Player Constants
const GRAVITY = -100
const JUMP_SPEED = 50
const ACCEL = 4.5

var health = 100

const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40


# Player Variables
var vel = Vector3()
var dir = Vector3()
var camera
var player_speed = 20
var rotation_helper
var MOUSE_SENSITIVITY = 0.05

var gui

func _ready():
	camera = $Rotation_Helper/Camera
	rotation_helper = $Rotation_Helper

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	gui = get_node("../GUI")
	
	gui.toggle_gold_bar(false)
	gui.toggle_ruby(false)
	gui.toggle_pearl(false)
	gui.set_health(100)
	gui.set_flashlight(100)

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)

func process_input(delta):

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
	# ----------------------------------

	# ----------------------------------
	# Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("movement_jump"):
			vel.y = JUMP_SPEED
	# ----------------------------------

	# ----------------------------------
#	# Capturing/Freeing the cursor
#	if Input.is_action_just_pressed("ui_cancel"):
#		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
#			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#		else:
#			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# ----------------------------------

	if Input.is_action_just_pressed("flashlight_click"):
		gui.set_flashlight(0)

	# Flashlight
	if Input.is_action_just_pressed("flashlight_toggle"):
		$Rotation_Helper/Flashlight.visible = not $Rotation_Helper/Flashlight.visible

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
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot
