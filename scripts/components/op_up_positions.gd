extends PostionComponent

var hand_move   = Vector3(0, -0.01, 1.7)
var hand_pos    = Vector3(0, -0.5, 1.7) 
var equiped_pos = Vector3(0.6, 0, 1.7)

func hand():
	if card.hand_position == 0:
		card.hand_position = card.get_hand_count()
	
	card.rotation = back_rotation
	await card.move_state(BaseCard.IN_HAND, hand_move)
	card.set_default_position(hand_pos)
	card.move_to_position()


func table():
	if card.table_position == 0:
		card.table_position = 3
	
	card.move_state(BaseCard.IN_TABLE)

func equip():
	card.position = hand_move
	card.set_default_position(equiped_pos)
	card.move_state(BaseCard.EQUIPED)
	card.rotation = front_rotation
