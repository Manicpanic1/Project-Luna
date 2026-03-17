extends CharacterBody2D

class_name Luna

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var coyote_timer = $CoyoteTimer

const SPEED = 275.0
const JUMP_VELOCITY = -600.0

#wall jump & slide


#jump counter
var jump_count = 0
var max_jump = 2
var dash_speed = 3.5
var is_dashing = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumpsMade = 0

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	if Input.is_action_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	if Input.is_action_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
		
	if not is_on_floor(): velocity.y += gravity * delta
	else: jumpsMade = 0
		
	if not is_on_floor(): velocity.y += gravity * delta
	
	if (is_on_floor() || !coyote_timer.is_stopped()):
		jump_count = 0

#jump handler
	if Input.is_action_just_pressed("jump") and jump_count < max_jump:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	
		if Input.is_action_just_pressed("jump") and not is_on_floor() and jump_count < max_jump:
			velocity.y = JUMP_VELOCITY
			jump_count += 2
	
	if Input.is_action_just_pressed("dash"):
		if !is_dashing and direction:
			start_dash()
	
	if direction:
		if is_dashing:
			velocity.x = direction * SPEED * dash_speed
		else:
			velocity.x = direction * SPEED
			
#Godot please, I beg of you
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_animation()
	
	var was_on_floor = is_on_floor()
	
	move_and_slide()

	
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
	
func _input(event : InputEvent):
	if(event.is_action_pressed("down") && is_on_floor()):
		position.y += 1

func start_dash():
	is_dashing = true
	$DashTimer.start()
	$DashTimer.connect("timeout",stop_dash)
func stop_dash():
	is_dashing = false
func update_animation():
	if velocity.x !=0:
		animation.play("run")
	else:
		animation.play("idle")
	
	if velocity.y < 0 :
		animation.play("jump")
	if velocity.y > 0 :
		animation.play("fall")
