extends GameState


func handle_play_button() -> GameState:
	parent.play_card()
	return null

func allow_hand_click(card: BaseCard) -> bool:
	if card is SupportCard:
		return true
	if card is ActionCard:
		return true
	return false  

func handle_hover(card: BaseCard) -> bool:
	#if card is ChampionCard:
		#return true
	if card is SupportCard:
		return true
	if card is ActionCard:
		return true
	return false  
