extends CardState

@onready var hand: CardState = $"../Hand"
@onready var table: CardState = $"../Table"
@onready var playing: CardState = $"../Playing"

func enter() -> void:
	card.position_component.deck()

func exit() -> void:
	if card is ActionCard:
		card.parent.action_deck_count -= 1
	elif card is SupportCard:
		card.parent.support_deck_count -= 1
	card.deck_position = 0

func process_click()-> CardState:
	card.set_actor()
	
	if card is SupportCard:
		card.parent.update_hand_count(1)
		return hand
	else:
		return playing
