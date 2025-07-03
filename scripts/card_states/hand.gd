extends CardState

@onready var table: CardState = $"../Table"

func enter() -> void:
	card.position_component.hand()

func update() -> void:
	enter()

func exit() -> void:
	card.hand_position = 0

func mouse_enter() -> CardState:
	if card.can_hover():
		card.do_hover_animation()
	return null

func mouse_leave() -> CardState:
	if card.can_hover() and card.hover:
		card.do_exit_hover_animation()
	return null

func handle_click() -> CardState:
	if card.actor.champion == Global.player_champion:
		return process_click()
	return null

func process_click()-> CardState:
	if card.handle_hand_click():
		return table
	return null
