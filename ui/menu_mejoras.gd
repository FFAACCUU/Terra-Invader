extends Control

var upgrade_option_scene := preload("res://ui/upgrade_option.tscn")

@onready var upgrades_container: HBoxContainer = $PanelContainer/UpgradesContainer

func _ready() -> void:
	SignalBus.connect("round_end", _on_round_end)
	SignalBus.connect("round_start", _on_round_start)

func _on_round_end(_round):
	visible = true
	get_random_upgrades()

func _on_round_start():
	clear_upgrades()
	visible = false

func clear_upgrades():
	for i in upgrades_container.get_children():
		upgrades_container.remove_child(i)

func get_random_upgrades():
	var test_1 := preload("res://resources/upgrades/damage_up.tres")
	var test_2 := preload("res://resources/upgrades/fire_rate_up.tres")
	var test_3 := preload("res://resources/upgrades/multishot.tres")
	
	var test_array : Array = [test_1, test_2, test_3]
	
	# ^ Variables para testear las opciones, borrar mas tarde.
	set_upgrade_resources(test_array)

func set_upgrade_resources(upgrades : Array):
	for i in upgrades:
		var new_upgrade = upgrade_option_scene.instantiate()
		new_upgrade.upgrade_res = i
		upgrades_container.add_child(new_upgrade)
