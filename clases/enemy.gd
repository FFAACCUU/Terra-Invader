extends CharacterBody2D
class_name Enemy

signal on_death

@onready var audio_hit = %AudioHit
@onready var audio_death = %AudioDeath
@onready var collision_shape = $CollisionShape2D

func _ready() -> void:
	SignalBus.connect("round_end", on_round_end)
	SignalBus.connect("game_over", on_round_end)

func on_damage_received(ammount : float):
	# Codigo que se ejecuta al recibir daño
	pass

func die():
	# Codigo que se ejecuta al morir
	pass

func on_round_end(round : int):
	# Codigo que se ejecuta al terminar una ronda
	pass

func play_death_sound():
	audio_death.play()

func play_hit_sound():
	audio_hit.play()

func disable_collision_shape():
	collision_shape.disabled = true
