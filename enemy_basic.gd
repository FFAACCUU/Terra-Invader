extends CharacterBody2D

@export var max_health : float
@onready var health : float = max_health

func _ready() -> void:
	look_at(Vector2(800, 450))

func take_damage(ammount : float):
	health -= ammount
	if health <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	look_at(Vector2(800, 450))
	move(delta)
	
	move_and_slide()

func move(delta : float):
	velocity += transform.x * 15 * delta
