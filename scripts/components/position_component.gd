class_name PostionComponent extends Node

var card: BaseCard
var front_rotation = Vector3(deg_to_rad(-90), deg_to_rad(180), 0.0)
var back_rotation  = Vector3(deg_to_rad(90), deg_to_rad(0), 0.0)
var sideA_rotation = Vector3(deg_to_rad(90), deg_to_rad(90), 0.0)
var sideB_rotation = Vector3(deg_to_rad(90), deg_to_rad(-90), 0.0)

func action_deck_position(y) -> Vector3:
	return Vector3(-0.5, y, 0.9)

func support_deck_position(y) -> Vector3: 
	return Vector3(0.5, y, 0.9)

func discard_position(y) -> Vector3:
	return Vector3(3, y, -0.9)

func deck():
	var y = (card.deck_position-1) * 0.005
	card.state = BaseCard.IN_DECK
	if card is ActionCard:
		card.position = action_deck_position(y)
		card.rotation = sideB_rotation
	elif card is SupportCard:
		card.position = support_deck_position(y)
		card.rotation = sideA_rotation

func discard():
	card.discard_position = card.get_discard_count()
	var y = card.discard_position * 0.005
	card.rotation = sideB_rotation
	card.move_to_position(discard_position(y), 0.5)
	card.state = BaseCard.IN_DISCARD

func hand():
	pass

func table():
	pass

func equip():
	pass
