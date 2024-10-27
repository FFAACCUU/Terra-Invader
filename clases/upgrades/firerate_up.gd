extends BaseUpgradeStrategy
class_name FireRateUpgrade

@export var firerate_increase : float = 1.0

func apply_upgrade(target : Node):
	target.fire_rate -= firerate_increase
