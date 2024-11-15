extends Timer

func  _ready():
	SignalBus.connect("round_end", on_round_end)
	SignalBus.connect("round_start", on_round_start)
	SignalBus.connect("game_over", _on_game_over)

func on_round_end(round : int):
	wait_time += 0.1

func on_round_start():
	start()

func _on_game_over(_round):
	autostart = false
	stop()
