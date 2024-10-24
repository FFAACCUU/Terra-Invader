extends Area2D
class_name HitBox

var damage : float

@onready var collision_shape = $CollisionShape2D

func set_disabled(is_disabled : bool):
	collision_shape.set_deferred("set_disabled", is_disabled)
