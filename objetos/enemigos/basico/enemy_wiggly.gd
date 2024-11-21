extends Enemy

@onready var hurt_box = $HurtBox
@onready var despawn_timer = $DespawnTimer

func _physics_process(delta: float) -> void:
	look_at(Vector2(816.0, 480.0))
	
	move_and_slide()

func on_damage_received(ammount : float):
	play_hit_sound()

func die():
	play_death_sound()
	visible = false
	call_deferred("disable_collision_shape")
	hurt_box.queue_free()
	despawn_timer.wait_time = 0.2
	despawn_timer.start()

func _on_despawn_timer_timeout():
	queue_free()
