extends PostionComponent

func hand():
	if card.hand_position == 0:
		card.hand_position = card.get_hand_count()
	
	#card.set_default_position(Vector3(1, 0, 2.4))
	card.set_default_position(Vector3(0, -0.1, 1.7))
	card.move_state(BaseCard.IN_HAND)


func table():
	if card.table_position == 0:
		card.table_position = 3
	
	card.move_state(BaseCard.IN_TABLE)

func equip():
	card.set_default_position(Vector3(0.6,0,1.7))
	card.move_state(BaseCard.IN_TABLE)
	card.rotation = Vector3(deg_to_rad(-90), deg_to_rad(180), 0.0)
