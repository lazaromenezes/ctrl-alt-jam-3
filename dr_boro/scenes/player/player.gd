extends CharacterBody2D

@export var default_speed = 200
@export var speed = 200

const _directions = {
	0: "right",
	90: "up",
	-180: "left",
	-90: "down"
}

func _ready():
	speed = default_speed

func _physics_process(_delta: float) -> void:
	
	var movement = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	if not movement or movement.length() < 1:
		$AnimatedSprite2D.play("idle")
	else:
		var direction = int(rad_to_deg(movement.angle_to(transform.x)))
		var animation = "walk_%s" % _directions[direction]
		$AnimatedSprite2D.play(animation)
		velocity = speed * movement
		move_and_slide()

