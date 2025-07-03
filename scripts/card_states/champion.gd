extends CardState

func enter() -> void:
	card.update_hover_position()
	card.move_to_position(card.default_position, 0.7)
	card.state = BaseCard.CHAMPION

func mouse_enter() -> CardState:
	if card.can_hover():
		card.do_hover_animation()
	return null

func mouse_leave() -> CardState:
	if card.can_hover() and card.hover:
		card.do_exit_hover_animation()
	return null
