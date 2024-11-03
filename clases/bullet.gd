extends Node2D
class_name Bullet

@onready var death_timer : Timer = $DeathTimer

@export var damage : float
@export var speed : float
@export var life_time : float

@onready var visuals: Node2D = %Visuals
@onready var hitbox : Area2D = %HitBox
@onready var hit_detector : Area2D = %HitDetector

func _ready() -> void:
	top_level = true
	death_timer.wait_time = life_time
	death_timer.start()
	hitbox.damage = damage

func _physics_process(delta):
	global_position += transform.x * speed * delta
	speed -= speed * 0.01

func set_parameters(new_scale : Vector2, dmg : float, spd : float, lftm : float):
	damage = dmg
	speed = spd
	life_time = lftm
	
	%Visuals.scale = new_scale
	%HitBox.scale = new_scale
	%HitDetector.scale = new_scale

func _on_death_timer_timeout() -> void:
	queue_free()

func _on_hit_detector_area_entered(area):
	queue_free()
