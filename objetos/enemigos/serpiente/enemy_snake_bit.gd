extends Enemy

@onready var hurt_box = $HurtBox
@onready var despawn_timer = $DespawnTimer

const HEAD_SCENE = preload("res://objetos/enemigos/serpiente/enemy_snake_head.tscn")

var next_segment : Enemy

func _ready() -> void:
	SignalBus.connect("round_end", on_round_end)
	
	if next_segment:
		next_segment.connect("on_death", on_next_segment_death)

func on_next_segment_death():
	call_deferred("turn_into_head")

func turn_into_head():
	var head_instance := HEAD_SCENE.instantiate()
	head_instance.global_position = global_position
	get_tree().root.add_child(head_instance)
	queue_free()

func _process(delta):
	calculate_curve_time(delta)

func _physics_process(delta: float) -> void:
	look_at(Vector2(816.0, 480.0))
	move(delta)
	
	move_and_slide()

func take_damage(ammount : float):
	health -= ammount
	if health <= 0:
		die()

func die():
	on_death.emit()
	queue_free()

func on_round_end(round : int):
	velocity = Vector2.ZERO
	speed = -speed * 10
	process_x = false
	process_y = false
	despawn_timer.start()

func _on_despawn_timer_timeout():
	queue_free()
