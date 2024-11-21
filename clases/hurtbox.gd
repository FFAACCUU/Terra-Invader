extends Area2D
class_name HurtBox

@export var owner_node : Node

signal damaged(ammount)

func _on_area_entered(hitbox : HitBox):
	damaged.emit(hitbox.damage)
