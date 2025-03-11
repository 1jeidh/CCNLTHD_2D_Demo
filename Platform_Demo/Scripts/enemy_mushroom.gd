extends Node2D

const SPEED = 400.0
var direction = 1

@onready var timer: Timer = $Area2D/Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
