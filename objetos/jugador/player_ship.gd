extends CharacterBody2D

@onready var bullet_marker = %BulletMarker
@onready var shoot_timer = $ShootTimer

@export var distance : float
@export var speed : float = 0.05
@export var bullet_scene : PackedScene
@export var bullet_damage : float
@export var bullet_speed : float
@export var bullet_life_time : float
@export var bullet_ammount : int
@export var fire_rate : float = 0.8

var can_shoot : bool = true

var upgrades : Array[BaseUpgradeStrategy] = []

func _ready():
	$Polygon2D.position.x = distance
	$CollisionShape2D.position.x = distance
	apply_upgrades()
	SignalBus.connect("upgrade_get", _on_get_upgrade)

func _process(_delta):
	if can_shoot && Input.is_action_pressed("Shoot"):
		shoot()

func _on_get_upgrade(upgrade : Upgrade):
	upgrades.append_array(upgrade.upgrade_resources)
	apply_upgrades()

func apply_upgrades():
	for strategy in upgrades:
		strategy.apply_upgrade(self)

func _physics_process(delta):
	move(delta, get_global_mouse_position())

func move(delta : float, target : Vector2):
	var vector = target - global_position
	var angle = vector.angle()
	
	#Rota la nave y el bullet marker hacia el mouse.
	global_rotation = lerp_angle(global_rotation, angle, Input.get_last_mouse_velocity().limit_length(speed).length() + speed)
	bullet_marker.global_rotation = lerp_angle(bullet_marker.global_rotation, angle, Input.get_last_mouse_velocity().limit_length(0.1).length() + 0.2)

func shoot():
	can_shoot = false
	create_bullet()
	shoot_timer.start(fire_rate)
	print(bullet_damage)

func create_bullet():
	shoot_multiple(5.0)

func set_bullet_postion(bullet : Node, offset):
	bullet.global_position = bullet_marker.global_position
	bullet.global_rotation_degrees = bullet_marker.global_rotation_degrees + offset
	var bullet_scale := Vector2((bullet_damage * 0.05) + 0.1, (bullet_damage * 0.05) + 0.1).clamp(Vector2(0.5, 0.5), Vector2(5.0, 5.0))
	bullet.visuals.scale = bullet_scale
	bullet.hitbox.scale = bullet_scale
	bullet.hit_detector.scale = bullet_scale

func set_bullet_params(bullet : Node):
	bullet.damage = bullet_damage
	bullet.speed = bullet_speed
	bullet.life_time = bullet_life_time

func _on_shoot_timer_timeout():
	can_shoot = true

func shoot_multiple(offset : float): #Dispara la misma cantidad de balas que bullet ammoun y calcula un offset para cada una.
	var current_offset : float = offset * 2
	instantiate_bullet(0)
	for i in bullet_ammount - 1:
		instantiate_bullet(current_offset)
		if current_offset > 0:
			current_offset = (current_offset + offset) * -1
		elif current_offset < 0:
			current_offset = (current_offset - offset) * -1

func instantiate_bullet(current_offset : float):
	var bullet_instance = bullet_scene.instantiate()
	set_bullet_params(bullet_instance)
	add_child(bullet_instance)
	set_bullet_postion(bullet_instance, current_offset)
