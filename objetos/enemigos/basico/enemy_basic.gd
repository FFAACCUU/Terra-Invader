extends CharacterBody2D

@export var max_health : float
@onready var health : float = max_health

@onready var hurt_box = $HurtBox
@onready var despawn_timer = $DespawnTimer

var speed : float = 15

func _ready() -> void:
	SignalBus.connect("round_end", on_round_end)
	
	look_at(Vector2(800, 450))

func take_damage(ammount : float):
	health -= ammount
	if health <= 0:
		die()

func die():
	queue_free()

func _physics_process(delta: float) -> void:
	look_at(Vector2(800, 450))
	move(delta)
	
	move_and_slide()

func move(delta : float):
	velocity += transform.x * speed * delta

func on_round_end(round : int):
	speed = -150
	hurt_box.monitoring = false
	despawn_timer.start()

func _on_despawn_timer_timeout():
	queue_free()
