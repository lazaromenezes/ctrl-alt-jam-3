extends CharacterBody2D

@export var default_speed = 100
@export var speed = 100

func _physics_process(_delta: float) -> void:
	
	look_at(get_global_mouse_position())
	
	var movement = Input.get_axis("move_backwards", "move_forward")

	velocity = transform.x * speed * movement
	
	move_and_slide()

