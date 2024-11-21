class_name HealthComponent
extends Node

@export var the_node : Node

@export_category("Health variables")
@export var max_health : float = 10
@onready var current_health : float = max_health

func take_damage(ammount : float):
	current_health -= ammount
	the_node.on_damage_received(current_health)
	if current_health <= 0:
		the_node.die()

func heal_damage(ammount : float):
	current_health += ammount
	if current_health >= max_health:
		current_health = max_health

func _on_hurt_box_damaged(ammount):
	take_damage(ammount)
