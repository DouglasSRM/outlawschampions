extends GameState

@onready var equip: GameState = $"../Equip"

func enter() -> void:
	if (parent.can_buy_support == 0):
		parent.can_buy_support = 1
		
	var card = parent.get_card_from_support_deck()
	
	while parent.move_locked:
		await get_tree().create_timer(0.1).timeout
	
	card.set_default_position()
	
	if parent.is_player_turn():
		parent.pop_card(card)
	else:
		parent.start_enemy_loop()


func handle_hover(card: BaseCard) -> bool:
	return false


func process_support_deck_click() -> GameState:
	parent.can_buy_support -= 1
	if (parent.can_buy_support > 0):
		return self
	return equip    
