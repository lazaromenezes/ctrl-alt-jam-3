extends CharacterBody2D

@export var default_speed = 200
@export var speed = 200

func _ready():
	speed = default_speed

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	var movement = Input.get_axis("move_backwards", "move_forward")
	velocity = transform.x * speed * movement
	move_and_slide()

