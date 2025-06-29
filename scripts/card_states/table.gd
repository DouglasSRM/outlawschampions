extends CardState

@onready var hand: CardState = $"../Hand"
@onready var equiped: CardState = $"../Equiped"

func enter() -> void:
	card.position_component.table()
	card.select()

func equip() -> CardState:
	return equiped

func update() -> void:
	enter()

func exit() -> void:
	card.table_position = 0

func process_click()-> CardState:
	if card.handle_table_click():
		return hand
	return null

func mouse_enter() -> CardState:
	if card.can_hover():
		card.do_hover_animation()
	return null

func mouse_leave() -> CardState:
	if card.can_hover() and card.hover:
		card.do_exit_hover_animation()
	return null
