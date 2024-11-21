class_name NPCMovementComponent
extends Node

@export var npc_node : Node

@export var speed : float = 10

@export_category("Movement curve")
@export var movement_curve : Curve
var time : float = 0
var curve_dir : int = 1
@export var factor : int = 0
@export var process_x : bool = false
@export var process_y : bool = false

func _ready():
	SignalBus.connect("round_end", on_round_end)

func _physics_process(delta):
	move(delta)

func _process(delta):
	calculate_curve_time(delta)

func move(delta : float):
	npc_node.velocity = ((npc_node.transform.y * do_the_curve()) + (npc_node.transform.x * (speed + (factor * 0.1)))) * delta

func do_the_curve() -> float:
	if movement_curve != null:
		return curve_movement()
	else:
		return 1.0

func calculate_curve_time(delta : float):
	if movement_curve != null:
		time += delta * curve_dir
		
		if time > 1: curve_dir = -1
		elif time < 0: curve_dir = 1
		time = clamp(time, 0, 1)

func curve_movement() -> float:
	if process_x:
		return movement_curve.sample(time) * factor
	if process_y:
		return movement_curve.sample(time / 2) * (factor / 2)
	return 0.0

func on_round_end(round : int):
	process_x = false
	process_y = false
	npc_node.velocity = Vector2.ZERO
	speed = -speed * 10
	npc_node.despawn_timer.start()
