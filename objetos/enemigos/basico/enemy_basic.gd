extends Enemy

@onready var hurt_box = $HurtBox
@onready var despawn_timer = $DespawnTimer

func take_damage(ammount : float):
	health -= ammount
	if health <= 0:
		die()

func die():
	queue_free()

func _process(delta):
	calculate_curve_time(delta)

func _physics_process(delta: float) -> void:
	look_at(Vector2(816.0, 480.0))
	move(delta)
	
	move_and_slide()

func on_round_end(round : int):
	velocity = Vector2.ZERO
	speed = -speed * 10
	despawn_timer.start()

func _on_despawn_timer_timeout():
	queue_free()
