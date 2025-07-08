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
	if card.hover:
		try_exit_hover()
	return null

func process_click() -> CardState:
	card.special_attack()
	return null

func handle_click() -> CardState:
	if !(card is ChampionCard):
		return null
	if card.can_use_special():
		return process_click()
	return null
	
