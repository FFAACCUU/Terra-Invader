extends Enemy

@onready var hurt_box = $HurtBox
@onready var despawn_timer = $DespawnTimer

const HEAD_SCENE = preload("res://objetos/enemigos/serpiente/enemy_snake_head.tscn")

var next_segment : Enemy

func _ready() -> void:
	SignalBus.connect("round_end", on_round_end)
	SignalBus.connect("game_over", on_round_end)
	if next_segment:
		next_segment.connect("on_death", on_next_segment_death)

func on_next_segment_death():
	call_deferred("turn_into_head")

func turn_into_head():
	var head_instance := HEAD_SCENE.instantiate()
	head_instance.global_position = position
	get_parent().add_child(head_instance)
	queue_free()

func _physics_process(delta: float) -> void:
	look_at(Vector2(816.0, 480.0))
	
	move_and_slide()

func on_damage_received(ammount : float):
	play_hit_sound()

func die():
	on_death.emit()
	play_death_sound()
	visible = false
	call_deferred("disable_collision_shape")
	hurt_box.queue_free()
	despawn_timer.wait_time = 0.2
	despawn_timer.start()

func _on_despawn_timer_timeout():
	queue_free()
