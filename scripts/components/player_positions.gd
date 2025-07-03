extends PostionComponent

var equiped_pos = Vector3(0.6,0,0.1) 

func hand():
	if card.hand_position == 0:
		card.hand_position = card.get_hand_count()
	
	var z: float = -1.75 # hand
	var card_distance: float = 0.6
	var initial_position: float = ((card_distance * (card.get_hand_count() - 1)) / 2)
	var x: float = initial_position - (card_distance * (card.hand_position - 1))
	
	card.set_default_position(Vector3(x, 0, z))
	card.move_state(BaseCard.IN_HAND)
	
	card.rotation = front_rotation

func table():
	if card.table_position == 0:
		card.table_position = 3
	
	var z: float = -0.85 # table
	var card_distance = 0.6
	var initial_position = ((card_distance * (card.get_table_count() - 1)) / 2)
	var x: float = initial_position - (card_distance * (card.table_position - 1))
	
	card.set_default_position(Vector3(x, 0, z))
	card.move_state(BaseCard.IN_TABLE)
	card.rotation = front_rotation

func equip():
	card.set_default_position(equiped_pos)
	card.move_state(BaseCard.EQUIPED)
	card.rotation = front_rotation
