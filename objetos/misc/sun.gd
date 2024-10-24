extends Sprite2D

@export var round_timer : Timer

func _ready():
	position = Vector2(0.0, -450.0)

func _process(delta):
	create_tween().tween_property(self, "position", Vector2(0.0, 450.0), round_timer.wait_time).set_trans(Tween.TRANS_LINEAR)
