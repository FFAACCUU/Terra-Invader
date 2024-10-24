extends BaseUpgradeStrategy
class_name DamageUpgrade

@export var damage_increase : float = 1.0

func apply_upgrade(target : Node):
	target.bullet_damage += damage_increase
