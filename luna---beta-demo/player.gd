extends CharacterBody2D

class_name Player

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var coyote_timer = $Coyote_Timer
@onready var wall_cling = $Wall_cling_Timer

const SPEED = 275.0
const JUMP_VELOCITY = -600.0

#jump counter
var jump_count = 0
var max_jump = 2
var dash_speed = 3.5
var is_dashing = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumpsMade = 0


#movement systems
func _physics_process(delta):
	var direction = Input.get_axis("Left", "Right")
	if Input.is_action_pressed("Left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	if Input.is_action_pressed("Right"):
		sprite.scale.x = abs(sprite.scale.x)
		
	if not is_on_floor(): velocity.y += gravity * delta
	else: jumpsMade = 0
		
	if not is_on_floor(): velocity.y += gravity * delta
	
	if (is_on_floor() || !coyote_timer.is_stopped()):
		jump_count = 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var was_on_floor = is_on_floor()


#jump handler
	if Input.is_action_just_pressed("Jump") and jump_count < max_jump:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	
		if Input.is_action_just_pressed("Jump") and not is_on_floor() and jump_count < max_jump:
			velocity.y = JUMP_VELOCITY
			jump_count += 2


	#Double jump handler
	if Input.is_action_just_pressed("Jump") and jump_count < max_jump:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	
		if Input.is_action_just_pressed("Jump") and not is_on_floor() and jump_count < max_jump:
			velocity.y = JUMP_VELOCITY
			jump_count += 2


#Kick Handler



#Wall Jump and slide Handler



#Shooting Handler



#Dash Handler
	if Input.is_action_just_pressed("Dash"):
		if !is_dashing and direction:
			start_dash()

	if direction:
		if is_dashing:
			velocity.x = direction * SPEED * dash_speed
		else:
			velocity.x = direction * SPEED


	move_and_slide()
	
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
	
func start_dash():
	is_dashing = true
	$Dash_Timer.start()
	$Dash_Timer.connect("timeout",stop_dash)
func stop_dash():
	is_dashing = false
