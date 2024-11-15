extends Control

@onready var barra_vida = %BarraVida
@onready var label_rondas = %LabelRondas


func _on_main_actualizar_rondas(cantidad):
	actualizar_label_de_rondas(cantidad)

func _on_main_actualizar_vida(cantidad):
	actualizr_barra_de_vida(cantidad)

func _on_main_actualizar_maximo_de_vida(cantidad):
	barra_vida.max_value = cantidad

func actualizr_barra_de_vida(vida_actual : int):
	barra_vida.value = vida_actual
	barra_vida.tooltip_text = "Cantidad de vida actual: " + str(vida_actual)

func actualizar_label_de_rondas(ronda_actual : int):
	label_rondas.text = str(ronda_actual)
	label_rondas.tooltip_text = "Numero de rondas: " + str(ronda_actual) + ". dificultad: " + str(ronda_actual * 0.1)
