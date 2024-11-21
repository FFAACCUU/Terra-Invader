extends Marker2D

const SNAKE_HEAD_SCENE := preload("res://objetos/enemigos/serpiente/enemy_snake_head.tscn")
const SNAKE_BIT_SCENE := preload("res://objetos/enemigos/serpiente/enemy_snake_bit.tscn")
var current_part : PackedScene

var last_part : Enemy

var random_ammount : int

func _ready():
	random_ammount = randi_range(3, 8)
	current_part = SNAKE_HEAD_SCENE

func spawn_snake_part(part : PackedScene):
	var part_instance = part.instantiate()
	
	part_instance.global_position = position
	
	if last_part != null:
		part_instance.next_segment = last_part
	
	get_parent().add_child(part_instance)
	
	last_part = part_instance

func _on_timer_timeout():
	if random_ammount != 0:
		spawn_snake_part(current_part)
		current_part = SNAKE_BIT_SCENE
		random_ammount -= 1
	else:
		queue_free()
