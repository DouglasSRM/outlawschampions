extends CardState

@onready var hand: CardState = $"../Hand"
@onready var table: Node = $"../Table"

func enter() -> void:
	var y = (card.deck_position-1) * 0.005
	
	if card is ActionCard:
		card.position = Vector3(-0.5, y, 0.9)
		card.rotation = Vector3(deg_to_rad(90), deg_to_rad(-90), 0.0)
	elif card is SupportCard:
		card.position = Vector3(0.5, y, 0.9)
		card.rotation = Vector3(deg_to_rad(90), deg_to_rad(90), 0.0)


func exit() -> void:
	if card is ActionCard:
		card.parent.action_deck_count -= 1
	elif card is SupportCard:
		card.parent.support_deck_count -= 1
	card.deck_position = 0

func mouse_enter() -> CardState:
	return super()

func mouse_leave() -> CardState:
	return super()

func process_click()-> CardState:
	if card is SupportCard:
		card.parent.update_hand_count(1)
		return hand
	if card is ActionCard:
		return table
	return null
