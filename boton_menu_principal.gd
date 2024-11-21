extends Node2D

signal elegir_menu_principal

var habilitado : bool = true #por ahora no hacen nada, pero estan aqui para despues poder ponerles animaciones

func take_damage(_ammount : float):
	if habilitado:
		elegir_menu_principal.emit()
		
		call_deferred("cambiar_escena")

func cambiar_escena():
	get_tree().change_scene_to_file("res://ui/menu_principal.tscn")

func _on_boton_jugar_elegir_jugar() -> void:
	habilitado = false

func _on_hurt_box_damaged(ammount):
	take_damage(ammount)
