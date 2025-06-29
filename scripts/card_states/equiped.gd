extends CardState

@onready var hand: CardState = $"../Hand"

func enter() -> void:
	if card.table_position == 0:
		card.table_position = 1
	
	var z: float = -0.85 # table
	var card_distance = 0.6

	var initial_position = ((card_distance * (card.get_table_count() - 1)) / 2)
	
	var x: float = initial_position - (card_distance * (card.table_position - 1))
	
	card.set_default_position(Vector3(x, 0, z))
	card.move_state(BaseCard.IN_TABLE)


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
