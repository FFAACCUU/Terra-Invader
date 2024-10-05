extends Node2D

var vida : int = 5

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	vida -= 1
	if vida <= 0:
		vida = 0
		get_tree().quit()
