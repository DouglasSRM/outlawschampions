extends GameState

@onready var buying_support: Node = $"../BuyingSupport"

func start_round() -> GameState:
	return buying_support
