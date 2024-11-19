extends CharacterBody2D
class_name Enemy

signal on_death

@export var max_health : float
@onready var health : float = max_health

@export var speed : float = 10

@export_category("Movement curve")
@export var movement_curve : Curve
var time : float = 0
var curve_dir : int = 1
@export var factor : int = 0
@export var process_x : bool = false
@export var process_y : bool = false

@onready var audio_hit = %AudioHit
@onready var audio_death = %AudioDeath
@onready var collision_shape = $CollisionShape2D

func _ready() -> void:
	SignalBus.connect("round_end", on_round_end)
	SignalBus.connect("game_over", on_round_end)

func move(delta : float):
	velocity = ((transform.y * do_the_curve()) + (transform.x * (speed + (factor * 0.1)))) * delta

func take_damage(ammount : float):
	# Codigo que se ejecuta al recibir daño
	pass

func die():
	# Codigo que se ejecuta al morir
	pass

func on_round_end(round : int):
	# Codigo que se ejecuta al terminar una ronda
	pass

func do_the_curve() -> float:
	if movement_curve != null:
		return curve_movement()
	else:
		return 1.0

func calculate_curve_time(delta : float):
	if movement_curve != null:
		time += delta * curve_dir
		
		if time > 1: curve_dir = -1
		elif time < 0: curve_dir = 1
		time = clamp(time, 0, 1)

func play_death_sound():
	audio_death.play()

func play_hit_sound():
	audio_hit.play()

func curve_movement() -> float:
	if process_x:
		return movement_curve.sample(time) * factor
	if process_y:
		return movement_curve.sample(time / 2) * (factor / 2)
	return 0.0

func disable_collision_shape():
	collision_shape.disabled = true
