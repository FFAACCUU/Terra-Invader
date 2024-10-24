extends Node2D

@export var upgrade_resources : Array[BaseUpgradeStrategy]

func _on_area_2d_body_entered(body):
	body.upgrades.append_array(upgrade_resources)
	body.apply_upgrades()
	queue_free()
