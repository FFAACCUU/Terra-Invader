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
@export var fire_rate : float = 0.6

var can_shoot : bool = true

var upgrades : Array[BaseUpgradeStrategy] = []

func _ready():
	$Polygon2D.position.x = distance
	$CollisionShape2D.position.x = distance
	set_all_upgrades()
	SignalBus.connect("upgrade_get", _on_get_upgrade)
	SignalBus.connect("game_over", _on_game_over)

func _process(_delta):
	if can_shoot && Input.is_action_pressed("Shoot"):
		shoot()

func _on_get_upgrade(upgrade : Upgrade):
	upgrades.append_array(upgrade.upgrade_resources)
	set_current_upgrades(upgrade.upgrade_resources)

func set_current_upgrades(upgrd : Array[BaseUpgradeStrategy]):
	
	# Aplica la mejora a la hora de esta ser agarrada por el jugador.
	
	for strategy in upgrd:
		strategy.apply_upgrade(self)

func set_all_upgrades():
	#------------------------------------------------------------------------------------------------------#
	# Aplica todas las mejoras que tiene el jugador, solo se requiere de aplicar al principio de la partida
	# si el jugador debe de espawnear con mejoras ya aplicadas o si se carga una partida anterior.
	#------------------------------------------------------------------------------------------------------# 
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
	create_bullet(5.0)
	shoot_timer.start(clamp(fire_rate, 0.01, 100.0))

func create_bullet(offset : float): #Dispara la misma cantidad de balas que bullet ammoun y calcula un offset para cada una.
	var current_offset : float = offset * 2
	instantiate_bullet(0)
	for i in bullet_ammount - 1:
		instantiate_bullet(current_offset)
		if current_offset > 0:
			current_offset = (current_offset + offset) * -1
		elif current_offset < 0:
			current_offset = (current_offset - offset) * -1

func set_bullet_postion(bullet : Node, offset):
	bullet.global_position = bullet_marker.global_position
	bullet.global_rotation_degrees = bullet_marker.global_rotation_degrees + offset

func set_bullet_params(bullet : Node):
	# Cambia la escala de el proyectil entre un tamaño minimo y uno maximo, basandose en el daño de este.
	var bullet_scale := Vector2((bullet_damage * 0.05) + 0.1, (bullet_damage * 0.05) + 0.1).clamp(Vector2(0.5, 0.5), Vector2(5.0, 5.0))
	bullet.set_parameters(bullet_scale, bullet_damage, bullet_speed, bullet_life_time)

func _on_shoot_timer_timeout():
	can_shoot = true

func instantiate_bullet(current_offset : float):
	var bullet_instance = bullet_scene.instantiate()
	set_bullet_params(bullet_instance)
	add_child(bullet_instance)
	set_bullet_postion(bullet_instance, current_offset)

func _on_game_over(_score):
	can_shoot = false
	$Polygon2D.position.x = 0.0
	# Fly away
