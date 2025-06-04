extends CardState

@onready var table: Node = $"../Table"

func enter() -> void:
	if parent.hand_position == 0:
		parent.hand_position = parent.get_hand_count()
	
	var z = -1.75 # hand
	var card_distance = 0.6
	# calcula a posição inicial das cartas
	var initial_position = ((card_distance * (parent.get_hand_count() - 1)) / 2)
	
	# diminui em 0.6 a posição x para cada carta
	var x: float = initial_position - (card_distance * (parent.hand_position - 1))
	
	parent.hand_pos = Vector3(x, 0, z)
	
	parent.update_hover_pos(parent.hand_pos)
	parent.move_state(parent.hand_pos, BaseCard.IN_HAND)
	parent.rotation = Vector3(deg_to_rad(-90), deg_to_rad(180), 0.0)


func update() -> void:
	enter()


func exit() -> void:
	parent.hand_position = 0

func mouse_enter() -> CardState:
	return super()

func mouse_leave() -> CardState:
	return super()

func process_click()-> CardState:
	return table;
