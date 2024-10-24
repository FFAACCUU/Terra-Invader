extends Timer

func  _ready():
	SignalBus.connect("round_end", on_round_end)
	SignalBus.connect("round_start", on_round_start)

func on_round_end(round : int):
	wait_time += 0.1

func on_round_start():
	start()
