extends CardState

func enter() -> void:
	card.position_component.discard()

func exit() -> void:
	card.discard_position = 0
