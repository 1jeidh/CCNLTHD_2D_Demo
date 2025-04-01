extends Node2D

@onready var timer: Timer = $Area2D/Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 150.0
var is_following = false
var player: Node2D = null 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_following and player != null:
		var direction_to_player = (player.position - position).normalized()
		position += direction_to_player * SPEED * delta
		if direction_to_player.x > 0:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false

func _on_sight_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		is_following = true
		player = body

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		var y_delta = position.y - body.position.y
		if y_delta > 30:
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
