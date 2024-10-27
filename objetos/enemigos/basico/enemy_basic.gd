extends CharacterBody2D

@export var max_health : float

@export var movement_curve : Curve
var time : float = 0
var curve_dir : int = 1
var factor : int = 300
@export var process_x : bool = false
@export var process_y : bool = false

@onready var health : float = max_health

@onready var hurt_box = $HurtBox
@onready var despawn_timer = $DespawnTimer

@export var speed : float = 10

func _ready() -> void:
	SignalBus.connect("round_end", on_round_end)
	
	look_at(Vector2(800, 450))

func take_damage(ammount : float):
	health -= ammount
	if health <= 0:
		die()

func die():
	queue_free()

func _process(delta):
	calculate_curve_time(delta)

func _physics_process(delta: float) -> void:
	look_at(Vector2(800, 450))
	move(delta)
	
	move_and_slide()

func move(delta : float):
	velocity += ((transform.y * curve_movement()) + (transform.x * (speed + (factor * 0.1)))) * delta

func on_round_end(round : int):
	velocity = Vector2.ZERO
	speed = -300
	process_x = false
	process_y = false
	despawn_timer.start()

func _on_despawn_timer_timeout():
	queue_free()

func calculate_curve_time(delta : float):
	if movement_curve:
		time += delta * curve_dir
		
		if time > 1: curve_dir = -1
		elif time < 0: curve_dir = 1
		time = clamp(time, 0, 1)
	

func curve_movement() -> float:
	if process_x:
		return movement_curve.sample(time) * factor
	if process_y:
		return movement_curve.sample(time / 2) * (factor / 2)
	return 0.0
