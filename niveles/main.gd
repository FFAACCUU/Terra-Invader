extends Node2D

var vida : int = 5

var current_round : int = 1

@onready var label = $Label

func _ready():
	update_round_text()

func update_round_text():
	label.text = str(current_round)

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	vida -= 1
	if vida <= 0:
		vida = 0
		get_tree().quit()

func _on_round_timer_timeout():
	current_round += 1
	update_round_text()
	SignalBus.emit_signal("round_end", current_round)
