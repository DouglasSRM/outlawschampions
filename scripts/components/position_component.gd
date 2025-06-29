class_name PostionComponent extends Node

var card: BaseCard

func deck():
	var y = (card.deck_position-1) * 0.005
	
	if card is ActionCard:
		card.position = Vector3(-0.5, y, 0.9)
		card.rotation = Vector3(deg_to_rad(90), deg_to_rad(-90), 0.0)
	elif card is SupportCard:
		card.position = Vector3(0.5, y, 0.9)
		card.rotation = Vector3(deg_to_rad(90), deg_to_rad(90), 0.0)
	card.state = BaseCard.IN_DECK

func discard():
	card.discard_position = card.get_discard_count()
	var y = card.discard_position * 0.005
	card.rotation = Vector3(deg_to_rad(90), deg_to_rad(-90), 0.0)
	card.move_to_position(Vector3(3, y, -0.9), 0.5)
	card.state = BaseCard.IN_DISCARD

func hand():
	pass

func table():
	pass

func equip():
	pass
