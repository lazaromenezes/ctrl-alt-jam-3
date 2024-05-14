extends CharacterBody2D

signal shot(power)

@export var default_speed = 200
@export var speed = 200
@export var max_shots = 5
@export var shot_cooldown = 0.5
@export var main_shot: PackedScene

enum Direction {RIGHT = 0, UP = 90, LEFT = 180, DOWN = 270}

var _shots_left = 0
var _movement = Vector2.ZERO

const _directions = {
	Direction.RIGHT: "right",
	Direction.UP: "up",
	Direction.LEFT: "left",
	Direction.DOWN: "down"
}

func _ready():
	_shots_left = max_shots
	speed = default_speed

func _physics_process(_delta: float) -> void:
	_movement = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	
	if not _movement or _movement.length() < 1:
		$AnimatedSprite2D.play("idle")
		_movement = Vector2.ZERO
	else:
		var angle = Utils.movement_positive_angle(_movement)
		var animation = "walk_%s" % _directions[angle]
		$AnimatedSprite2D.flip_h = angle == Direction.LEFT
		$AnimatedSprite2D.play(animation)
		velocity = speed * _movement
		move_and_slide()

func _unhandled_input(event):
	if main_shot and event.is_action_pressed("shot") and _shots_left > 0:
		_shot()

func _shot():
	var power: Node2D = main_shot.instantiate()
	power.position = position
	power.direction = _movement
	shot.emit(power)


