extends Node

var points = 0
@onready var points_label: Label = %Points_Label

func add_point():
	points += 1
	print(points)
	points_label.text = "Points: " + str(points)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
