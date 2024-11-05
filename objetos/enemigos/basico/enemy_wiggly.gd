extends Enemy

@onready var hurt_box = $HurtBox
@onready var despawn_timer = $DespawnTimer

func _ready() -> void:
	SignalBus.connect("round_end", on_round_end)

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
	queue_free()

func on_round_end(round : int):
	velocity = Vector2.ZERO
	speed = -300
	process_x = false
	process_y = false
	despawn_timer.start()

func _on_despawn_timer_timeout():
	queue_free()
