extends PostionComponent

func hand():
	if card.hand_position == 0:
		card.hand_position = card.get_hand_count()
	
	card.move_state(BaseCard.IN_HAND,Vector3(-1.8, -0.01, 0.9))
	card.set_default_position(Vector3(-1.8, -0.1, 0.9))
	card.move_to_position()


func table():
	if card.table_position == 0:
		card.table_position = 3
	
	card.move_state(BaseCard.IN_TABLE)

func equip():
	card.set_default_position(Vector3(-1.8,0,0))
	card.move_state(BaseCard.IN_TABLE)
	card.rotation = Vector3(deg_to_rad(-90), deg_to_rad(180), 0.0)
