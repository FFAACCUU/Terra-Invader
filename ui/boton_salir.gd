extends Node2D

var habilitado : bool = true

func take_damage(_ammount : float):
	if habilitado:
		get_tree().quit()


func _on_boton_jugar_elegir_jugar() -> void:
	habilitado = false
