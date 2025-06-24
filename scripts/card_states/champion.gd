extends CardState

func enter() -> void:
	card.update_hover_position(card.default_position)
	card.move_to_position(card.default_position, 0.7)
	card.state = BaseCard.CHAMPION
	#card.move_state(card.default_position, BaseCard.CHAMPION)


func mouse_enter() -> CardState:
	if !card.is_locked_for_movement():
		card.do_hover_animation()
	return null


func mouse_leave() -> CardState:
	if !card.is_locked_for_movement() and card.hover:
		card.do_exit_hover_animation()
	return null


func process_click()-> CardState:
	return super();
