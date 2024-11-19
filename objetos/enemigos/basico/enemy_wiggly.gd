extends Enemy

@onready var hurt_box = $HurtBox
@onready var despawn_timer = $DespawnTimer

func _process(delta):
	calculate_curve_time(delta)

func _physics_process(delta: float) -> void:
	look_at(Vector2(816.0, 480.0))
	move(delta)
	
	move_and_slide()

func take_damage(ammount : float):
	health -= ammount
	play_hit_sound()
	if health <= 0:
		die()

func die():
	play_death_sound()
	visible = false
	call_deferred("disable_collision_shape")
	hurt_box.queue_free()
	despawn_timer.wait_time = 0.2
	despawn_timer.start()

func on_round_end(round : int):
	velocity = Vector2.ZERO
	speed = -speed * 10
	process_x = false
	despawn_timer.start()

func _on_despawn_timer_timeout():
	queue_free()
