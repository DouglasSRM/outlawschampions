extends CardState


func enter() -> void:
	card.discard_position = card.get_discard_count()
	var y = card.discard_position * 0.005
	card.rotation = Vector3(deg_to_rad(90), deg_to_rad(-90), 0.0)
	card.move_state(Vector3(3, y, -0.9), BaseCard.IN_DISCARD)


func exit() -> void:
	card.discard_position = 0

func mouse_enter() -> CardState:
	return super()

func mouse_leave() -> CardState:
	return super()

func process_click()-> CardState:
	return super()
