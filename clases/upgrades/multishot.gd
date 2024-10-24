extends BaseUpgradeStrategy
class_name MultishotUpgrade

@export var ammount_increase : int = 1

func apply_upgrade(target : Node):
	target.bullet_ammount += ammount_increase
