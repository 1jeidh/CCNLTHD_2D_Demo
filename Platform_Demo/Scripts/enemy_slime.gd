extends Node2D

@onready var timer: Timer = $Area2D/Timer
@onready var ray_cast_2d_left: RayCast2D = $RayCast2D_Left
@onready var ray_cast_2d_right: RayCast2D = $RayCast2D_Right
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_2d_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = false
	if ray_cast_2d_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = true
	position.x += direction * SPEED * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "CharacterBody2D"):
		#Enemy y position - PLayer y position
		var y_delta = position.y - body.position.y
		if(y_delta > 30):
			print("Destroy enemy")
			queue_free()
			body.jump()
		else:
			print("You die")
			Engine.time_scale = 0.5
			body.get_node("CollisionShape2D").queue_free()
			timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
