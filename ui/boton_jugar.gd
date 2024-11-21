extends Node2D

signal elegir_jugar

var habilitado : bool = true #por ahora no hacen nada, pero estan aqui para despues poder ponerles animaciones

func take_damage(_ammount : float):
	if habilitado:
		elegir_jugar.emit()
		
		call_deferred("cambiar_escena")

func cambiar_escena():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_hurt_box_damaged(ammount):
	take_damage(ammount)
