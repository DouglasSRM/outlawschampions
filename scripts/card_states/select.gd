extends CardState

@onready var champion: Node = $"../Champion"

func enter() -> void:
	card.default_position = card.position
	card.update_hover_position()
	card.state = BaseCard.SELECT


func mouse_enter() -> CardState:
	if card.can_hover():
		card.do_hover_animation()
	return null


func mouse_leave() -> CardState:
	if card.can_hover() and card.hover:
		card.do_exit_hover_animation()
	return null


func process_click() -> CardState:
	card.select()
	return null;
