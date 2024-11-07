extends Node2D

@onready var main = get_node("/root/Main")

var enemigo_escena : Array = [preload("res://objetos/enemigos/basico/enemy_basic.tscn"), preload("res://objetos/enemigos/basico/enemy_wiggly.tscn"), preload("res://objetos/enemigos/serpiente/snake_spawner.tscn")]
var spawn_points := []

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("round_end", on_round_end)
	SignalBus.connect("round_start", on_round_start)
	
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)

func _on_timer_timeout():
	var spawn = spawn_points [randi() % spawn_points.size()]
	var enemigo = enemigo_escena.pick_random().instantiate()
	enemigo.position = spawn.position
	main.add_child(enemigo)

func on_round_end(_round : int):
	$Timer.stop()

func on_round_start():
	$Timer.start()
