class_name Player
extends CharacterBody3D

@onready var spring_arm_3d = $SpringArm3D
var speed := 6.0
var mouse_sens = .01
var dir := Vector3.ZERO
@onready var model = $playerModel
@onready var anim = $playerModel/AnimationPlayer
@onready var anim_tree = $AnimationTree

var canMove = true
var hasGameStarted = false
# Called when the node enters the scene tree for the first time.
func _ready():
	canMove = false
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	if canMove:
		move_character(delta)
	anim_tree.set("parameters/idleWalk/blend_position",velocity.length() / speed)
	if dir != Vector3.ZERO:
		$CPUParticles3D.emitting = true
	else:
		$CPUParticles3D.emitting = false
	if !is_on_floor():
		velocity.y -= 9 * delta
	move_and_slide()
	
func move_character(delta):
	dir = Vector3.ZERO
	dir.x = Input.get_axis("ui_left","ui_right")
	dir.z = Input.get_axis("ui_up","ui_down")
	dir  = dir.rotated(Vector3.UP, spring_arm_3d.rotation.y).normalized()
	if dir != Vector3.ZERO:
		velocity.x = lerp(velocity.x, dir.x * speed, .3)
		velocity.z = lerp(velocity.z, dir.z * speed, .3)
		model.rotation.y = lerp_angle(model.rotation.y, atan2(velocity.x, velocity.z),.3)
	else:
		velocity.x = lerp(velocity.x, 0.0, .3)
		velocity.z = lerp(velocity.z, 0.0, .3)
func _process(delta):
	if canMove:
		readCameraFromJoystick()
func readCameraFromJoystick():
		if Input.is_action_pressed("look_up"):
			spring_arm_3d.rotation.x -= 10 * mouse_sens
			spring_arm_3d.rotation.x = clamp(spring_arm_3d.rotation.x, -PI/2, PI/4)
			
		if Input.is_action_pressed("look_down"):
			spring_arm_3d.rotation.x += 10 * mouse_sens
			spring_arm_3d.rotation.x = clamp(spring_arm_3d.rotation.x, -PI/2, PI/4)
			
		if Input.is_action_pressed("look_left"):
			spring_arm_3d.rotation.y -= 10 * mouse_sens
		if Input.is_action_pressed("look_right"):
			spring_arm_3d.rotation.y += 10 * mouse_sens
	
		
func _input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if canMove:
		if event is InputEventMouseMotion:
			spring_arm_3d.rotation.x -= event.relative.y * mouse_sens
			spring_arm_3d.rotation.x = clamp(spring_arm_3d.rotation.x, -PI/2, PI/4)
			spring_arm_3d.rotation.y -= event.relative.x * mouse_sens

		#Modificar el zoom de la camara
		if Input.is_action_just_pressed("mouseWheelUp"):
			spring_arm_3d.spring_length-=.5
			spring_arm_3d.spring_length = clamp(spring_arm_3d.spring_length,1.0,8.0)
		elif Input.is_action_just_pressed("mouseWheelDown"):
			spring_arm_3d.spring_length+=.5
			spring_arm_3d.spring_length = clamp(spring_arm_3d.spring_length,1.0,8.0)
		
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = 0
			velocity.y += 5
	
	if !hasGameStarted and Input.is_action_just_pressed("jump"):
		hasGameStarted = true
		canMove = true
		spring_arm_3d.spring_length = 3
	
	
	if Input.is_action_just_pressed("click") and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func playStepsSounds():
	if is_on_floor() and velocity.length() > .2:
		$pisadasAudio.pitch_scale = randf_range(.8,1.2)
		$pisadasAudio.play()
