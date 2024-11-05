extends Sprite2D

@export var round_timer : Timer

var is_done : bool = false

func _ready():
	position = Vector2(0.0, -480.0)
	SignalBus.connect("round_start", _on_round_start)
	SignalBus.connect("round_end", _on_round_end)

func _process(delta):
	var position_tween : Tween = create_tween()
	if !is_done:
		position_tween.tween_property(self, "position", Vector2(0.0, 480.0), round_timer.wait_time).set_trans(Tween.TRANS_LINEAR)
	else:
		position_tween.stop()
		position = Vector2(0.0, -480.0)

func _on_round_start():
	is_done = false

func _on_round_end(_round : int):
	is_done = true
