extends GameState

@onready var attack: Node = $"../Attack"

func enter() -> void:
	#if (parent.can_buy_action == 0):
		#parent.can_buy_action = 1
	
	var card = parent.get_card_from_action_deck()
	
	while parent.move_locked:
		await get_tree().create_timer(0.1).timeout
	
	card.set_default_position()
	parent.pop_card(card)


func handle_hover(card: BaseCard) -> bool:
	return false


func process_action_deck_click() -> GameState:
	#parent.can_buy_action -= 1
	#if (parent.can_buy_action > 0):
		#return self
	return attack    
