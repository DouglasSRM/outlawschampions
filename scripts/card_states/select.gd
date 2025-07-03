extends CardState

func enter() -> void:
	card.set_default_position()
	card.state = BaseCard.SELECT

func mouse_enter() -> CardState:
	if card.can_hover():
		card.do_hover_animation()
	return null

func mouse_leave() -> CardState:
	if card.can_hover() and card.hover:
		card.do_exit_hover_animation()
	return null

func handle_click() -> CardState:
	return process_click()

func process_click() -> CardState:
	card.select()
	return null;
