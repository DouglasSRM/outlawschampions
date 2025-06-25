extends GameState

@onready var equip: GameState = $"../Equip"

func enter() -> void:
	if (parent.can_buy_support == 0):
		parent.can_buy_support = 1
		
	var card = parent.get_card_from_support_deck()
	
	while parent.move_locked:
		await get_tree().create_timer(0.1).timeout
	
	card.set_default_position()
	parent.pop_card(card)


func handle_hover(card: BaseCard) -> bool:
	#if card is ChampionCard:
		#return true
	return false


func process_support_deck_click() -> GameState:
	parent.can_buy_support -= 1
	print('a')
	if (parent.can_buy_support > 0):
		print('b')
		return self
	return equip    
