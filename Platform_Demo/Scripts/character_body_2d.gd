extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -550.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func jump():
	velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	#Animations
	if(velocity.x > 1 || velocity.x < -1):
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#Direction
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	move_and_slide()
