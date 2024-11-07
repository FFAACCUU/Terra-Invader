extends Marker2D

@onready var snake_head_scene := preload("res://objetos/enemigos/serpiente/enemy_snake_head.tscn")
@onready var snake_bit_scene := preload("res://objetos/enemigos/serpiente/enemy_snake_bit.tscn")
var current_part : PackedScene

var random_ammount : int

func _ready():
	random_ammount = randi_range(3, 8)
	current_part = snake_head_scene

func spawn_snake_part(part : PackedScene):
	var part_instance = part.instantiate()
	part_instance.global_position = global_position
	get_tree().root.add_child(part_instance)

func _on_timer_timeout():
	if random_ammount != 0:
		spawn_snake_part(current_part)
		current_part = snake_bit_scene
		random_ammount -= 1
	else:
		queue_free()
