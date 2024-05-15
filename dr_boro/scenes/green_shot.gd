extends Area2D

@export var speed = 300

const BASE_ROTATION = 90

var _collided = false

var direction: Vector2:
	set(value):
		if not value:
			value = Vector2.DOWN
		
		direction = value
		var angle = (Utils.movement_positive_angle(direction) + BASE_ROTATION) * -1
		rotate(deg_to_rad(angle))

func _physics_process(delta):
	if not _collided:
		position += direction * speed * delta

func _on_body_entered(_body):
	_collided = true
	$AnimatedSprite2D.play("explode")
	$CPUParticles2D.emitting = true
	await $AnimatedSprite2D.animation_finished
	call_deferred("queue_free")
