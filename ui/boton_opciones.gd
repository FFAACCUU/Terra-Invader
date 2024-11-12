extends Node2D

signal elegir_opciones

var habilitado : bool = true

func take_damage(_ammount : float):
	if habilitado:
		elegir_opciones.emit()
		print("Hola")

func _on_boton_jugar_elegir_jugar() -> void:
	habilitado = false
