extends GameState

@onready var buying_support: Node = $"../BuyingSupport"
@onready var locked: Node = $"../Locked"

func enter() -> void:
	var card = parent.get_card_from_action_deck()
	
	while parent.move_locked:
		await get_tree().create_timer(0.1).timeout
	
	card.set_default_position()
	if parent.is_player_turn():
		parent.pop_card(card)


func handle_play_button() -> GameState:
	await parent.play_card()
	return buying_support


func process_action_deck_click() -> GameState:
	if parent.selected_card:
		parent.selected_card.execute_click()
	return locked


func allow_hand_click(card: BaseCard) -> bool:
	if !parent.is_player_turn():
		return false
	
	if card is ActionCard:
		return true
	return false  


func handle_hover(card: BaseCard) -> bool:
	if !parent.is_player_turn():
		return false
	
	if card is ActionCard:
		return true
	return false  
