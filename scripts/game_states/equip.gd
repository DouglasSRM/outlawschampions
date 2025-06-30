extends GameState

@onready var attack: Node = $"../Attack"

func handle_play_button() -> GameState:
	parent.play_card()
	return attack


func allow_hand_click(card: BaseCard) -> bool:
	if card.actor.champion == Global.player_champion and !parent.is_player_turn():
		return false
	
	if card is SupportCard:
		return true
	return false  


func handle_hover(card: BaseCard) -> bool:
	if !parent.is_player_turn() and  card.actor and card.actor.champion == Global.player_champion:
		return false
	
	if card is SupportCard:
		return true
	return false  
