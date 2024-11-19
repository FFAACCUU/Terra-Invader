extends Node2D

@onready var main = get_node("/root/Main")

var enemigo_escena : Array = [preload("res://objetos/enemigos/basico/enemy_basic.tscn")]
var spawn_points := []

var set_of_rounds : int = 0
var dificulty : int = 1

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = 2.0
	
	SignalBus.connect("round_end", on_round_end)
	SignalBus.connect("game_over", on_round_end)
	SignalBus.connect("round_start", on_round_start)
	
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

func _on_timer_timeout():
	var spawn = spawn_points [randi() % spawn_points.size()]
	var enemigo = enemigo_escena.pick_random().instantiate()
	enemigo.position = spawn.position
	main.add_child(enemigo)

func on_round_end(round : int):
	set_enemies_by_dificulty()
	$Timer.stop()

func set_enemies_by_dificulty():
	match dificulty:
		1:
			set_dificulty_by_rounds(2)
			enemigo_escena = [preload("res://objetos/enemigos/basico/enemy_basic.tscn")]
			timer.wait_time = 2.0
		2:
			set_dificulty_by_rounds(4)
			enemigo_escena = [preload("res://objetos/enemigos/basico/enemy_basic.tscn"), preload("res://objetos/enemigos/basico/enemy_wiggly.tscn")]
			timer.wait_time = 1.0
		3:
			set_dificulty_by_rounds(1)
			enemigo_escena = [preload("res://objetos/enemigos/serpiente/snake_spawner.tscn")]
			timer.wait_time = 2.2
		4:
			enemigo_escena = [preload("res://objetos/enemigos/basico/enemy_basic.tscn"), preload("res://objetos/enemigos/basico/enemy_wiggly.tscn"), preload("res://objetos/enemigos/serpiente/snake_spawner.tscn")]
			timer.wait_time = 0.6

func set_dificulty_by_rounds(ammount : int):
	set_of_rounds += 1
	if set_of_rounds >= ammount:
		set_of_rounds = 0
		dificulty += 1

func on_round_start():
	$Timer.start()
