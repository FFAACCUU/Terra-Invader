extends Node2D

var vida : int = 5

var current_round : int = 1

signal actualizar_vida(cantidad : int)
signal actualizar_maximo_de_vida(cantidad : int)
signal actualizar_rondas(cantidad : int)

@onready var planet = %Planet
@onready var round_timer = %RoundTimer

func _ready():
	SignalBus.connect("game_over", _on_game_over)
	actualizar_maximo_de_vida.emit(vida)
	actualizar_vida.emit(vida)
	actualizar_rondas.emit(current_round)

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	vida -= 1
	actualizar_vida.emit(vida)
	if vida <= 0:
		vida = 0
		SignalBus.game_over.emit(current_round)

func _on_round_timer_timeout():
	current_round += 1
	actualizar_rondas.emit(current_round)
	SignalBus.emit_signal("round_end", current_round)

func _on_game_over(_score):
	planet.queue_free()
