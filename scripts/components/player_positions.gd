extends PostionComponent

func hand():
	if card.hand_position == 0:
		card.hand_position = card.get_hand_count()
	
	var z: float = -1.75 # hand
	var card_distance: float = 0.6
	
	var initial_position: float = ((card_distance * (card.get_hand_count() - 1)) / 2)
	var x: float = initial_position - (card_distance * (card.hand_position - 1))
	
	card.set_default_position(Vector3(x, 0, z))
	card.move_state(BaseCard.IN_HAND)
	
	card.rotation = Vector3(deg_to_rad(-90), deg_to_rad(180), 0.0)

func table():
	if card.table_position == 0:
		card.table_position = 3
	
	var z: float = -0.85 # table
	var card_distance = 0.6
	
	var initial_position = ((card_distance * (card.get_table_count() - 1)) / 2)
	
	var x: float = initial_position - (card_distance * (card.table_position - 1))
	
	card.set_default_position(Vector3(x, 0, z))
	card.move_state(BaseCard.IN_TABLE)
	card.rotation = Vector3(deg_to_rad(-90), deg_to_rad(180), 0.0)

func equip():
	#card.table_position = 1
	#table()
	card.set_default_position(Vector3(0.6,0,0.1))
	#card.set_default_position(Vector3(0.6,0,1.7))
	card.move_state(BaseCard.EQUIPED)
	#ard.state = BaseCard.EQUIPED
