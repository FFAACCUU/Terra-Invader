extends Node2D
class_name Bullet

@onready var death_timer : Timer = $DeathTimer

@export var damage : float
@export var speed : float
@export var life_time : float

@onready var visuals : Polygon2D = $Polygon2D
@onready var hitbox : Area2D = $HitBox

func _ready() -> void:
	death_timer.wait_time = life_time
	death_timer.start()
	hitbox.damage = damage

func _physics_process(delta):
	global_position += transform.x * speed * delta
	speed -= speed * 0.01

func _on_death_timer_timeout() -> void:
	queue_free()
