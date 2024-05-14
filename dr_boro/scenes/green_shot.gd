extends Area2D

@export var speed = 300

const BASE_ROTATION = 90

var direction: Vector2:
	set(value):
		if not value:
			value = Vector2.DOWN
		
		direction = value
		var angle = (Utils.movement_positive_angle(direction) + BASE_ROTATION) * -1
		rotate(deg_to_rad(angle))

func _physics_process(delta):
	position += direction * speed * delta

