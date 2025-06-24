extends CardState

@onready var hand: CardState = $"../Hand"

func enter() -> void:
	if card.table_position == 0:
		card.table_position = card.get_table_count()
	
	var z: float = -0.85 # table
	var card_distance = 0.6

	var initial_position = ((card_distance * (card.get_table_count() - 1)) / 2)
	
	var x: float = initial_position - (card_distance * (card.table_position - 1))
	
	var table_pos = Vector3(x, 0, z)
	card.move_state(table_pos, BaseCard.IN_TABLE)


func exit() -> void:
	card.table_position = 0


func process_click()-> CardState:
	if card.handle_table_click():
		return hand
	return null
