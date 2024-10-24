extends Area2D
class_name HurtBox

func _on_area_entered(hitbox : HitBox):
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
