extends Area2D
class_name HurtBox

@export var owner_node : Node

func _on_area_entered(hitbox : HitBox):
	if owner_node.has_method("take_damage"):
		owner_node.take_damage(hitbox.damage)
