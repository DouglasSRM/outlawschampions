extends CardState

func enter() -> void:
	card.position_component.equip()
	
	var round = card.parent.round
	while card.parent.round < round+4:
		await get_tree().create_timer(0.5).timeout
	
	card.parent.handle_discard(card)

func exit() -> void:
	card.table_position = 0

func mouse_enter() -> CardState:
	if card.can_hover():
		card.do_hover_animation()
	return null

func mouse_leave() -> CardState:
	if card.can_hover() and card.hover:
		card.do_exit_hover_animation()
	return null
