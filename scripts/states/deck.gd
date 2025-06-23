extends CardState

@onready var hand: CardState = $"../Hand"

func enter() -> void:
	var y = (card.deck_position-1) * 0.005
	
	if card is ActionCard:
		card.position = Vector3(-0.5, y, 0.9)
		card.rotation = Vector3(deg_to_rad(90), deg_to_rad(-90), 0.0)
	elif card is SupportCard:
		card.position = Vector3(0.5, y, 0.9)
		card.rotation = Vector3(deg_to_rad(90), deg_to_rad(90), 0.0)


func exit() -> void:
	card.deck_position = 0

func mouse_enter() -> CardState:
	return super()

func mouse_leave() -> CardState:
	return super()

func process_click()-> CardState:
	return hand
