extends CharacterBody2D

signal shot(power)
signal charged(power)

@export var default_speed = 200
@export var speed = 200
@export var max_shots = 5
@export var shot_cooldown = 1.5
@export var main_shot: PackedScene
@export var health = 5

enum Direction {RIGHT = 0, UP = 90, LEFT = 180, DOWN = 270}

var _shots_left = 0
var _direction = Vector2.RIGHT
var _is_shooting = false

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
	velocity = Vector2.ZERO
	
	if not _is_shooting:
		var movement = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	
		var angle = Utils.movement_positive_angle(_direction)
		$AnimatedSprite2D.flip_h = angle == Direction.LEFT
		
		if not movement or movement.length() < 1:
			$AnimatedSprite2D.play("idle_%s" % _directions[angle])
		else:
			_direction = movement
			var animation = "walk_%s" % _directions[angle]
			$AnimatedSprite2D.play(animation)
			velocity = speed * _direction
			move_and_slide()

func _unhandled_input(event):
	if main_shot and event.is_action_pressed("shot") and _shots_left > 0:
		_is_shooting = true
		var angle = Utils.movement_positive_angle(_direction)
		$AnimatedSprite2D.play("shot_%s" % _directions[angle])
		_shot()
		_shots_left -= 1
		_recharge()
		await $AnimatedSprite2D.animation_finished
		_is_shooting = false

func _shot():
	var power: Node2D = main_shot.instantiate()
	power.position = position
	power.direction = _direction
	shot.emit(power)

func _recharge():
	if _shots_left < 5:
		await get_tree().create_timer(shot_cooldown).timeout
		_shots_left += 1
		charged.emit(_shots_left)
