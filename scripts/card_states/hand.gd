extends CardState

@onready var table: Node = $"../Table"

func enter() -> void:
	if card.hand_position == 0:
		card.hand_position = card.get_hand_count()
	
	var z: float = -1.75 # hand
	var card_distance: float = 0.6
	
	var initial_position: float = ((card_distance * (card.get_hand_count() - 1)) / 2)
	var x: float = initial_position - (card_distance * (card.hand_position - 1))
	
	card.default_position = Vector3(x, 0, z)
	card.update_hover_position(card.default_position)
	
	card.move_state(card.default_position, BaseCard.IN_HAND)
	card.rotation = Vector3(deg_to_rad(-90), deg_to_rad(180), 0.0)


func update() -> void:
	enter()


func exit() -> void:
	card.hand_position = 0


func mouse_enter() -> CardState:
	if !card.is_locked_for_movement():
		card.do_hover_animation()
	return null


func mouse_leave() -> CardState:
	if !card.is_locked_for_movement() and card.hover:
		card.do_exit_hover_animation()
	return null


func process_click()-> CardState:
	if card.handle_hand_click():
		return table
	return null
