extends Control

@onready var barra_vida = %BarraVida
@onready var label_rondas = %LabelRondas


func _on_main_actualizar_rondas(cantidad):
	label_rondas.text = str(cantidad)

func _on_main_actualizar_vida(cantidad):
	barra_vida.value = cantidad

func _on_main_actualizar_maximo_de_vida(cantidad):
	barra_vida.max_value = cantidad
