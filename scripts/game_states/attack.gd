extends GameState

@onready var buying_support: Node = $"../BuyingSupport"

func handle_play_button() -> GameState:
	await parent.play_card()
	return buying_support


func allow_hand_click(card: BaseCard) -> bool:
	if card is ActionCard:
		return true
	return false  


func handle_hover(card: BaseCard) -> bool:
	if card is ActionCard:
		return true
	return false  
