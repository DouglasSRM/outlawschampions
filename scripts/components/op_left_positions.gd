extends PostionComponent

var hand_move   = Vector3(1.8, 0, 0.9)
var hand_pos    = Vector3(1.8, -5, 0.9) 
var equiped_pos = Vector3(1.8, 0, 0)

func hand():
	if card.hand_position == 0:
		card.hand_position = card.get_hand_count()
	
	card.rotation = back_rotation
	await card.move_state(BaseCard.IN_HAND, hand_move)
	card.set_default_position(hand_pos)
	card.move_to_position()
	card.visible = false

func table():
	card.visible = true
	if card.table_position == 0:
		card.table_position = 3
	
	card.move_state(BaseCard.IN_TABLE)

func equip():
	card.visible = true
	card.position = hand_move
	card.set_default_position(equiped_pos)
	card.move_state(BaseCard.EQUIPED)
	card.rotation = front_rotation
