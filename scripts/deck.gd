extends CardState

@onready var hand: CardState = $"../Hand"

func enter() -> void:
	var y = parent.deck_position * 0.005
	
	var position
	var rotation
	if parent is ActionCard:
		position = Vector3(-0.5, y, 0.9)
		rotation = Vector3(deg_to_rad(90), deg_to_rad(-90), 0.0)
	elif parent is SupportCard:
		position = Vector3(0.5, y, 0.9)
		rotation = Vector3(deg_to_rad(90), deg_to_rad(90), 0.0)
	
	parent.position = position
	parent.rotation = rotation


func exit() -> void:
	parent.deck_position = 0

func mouse_enter() -> CardState:
	return super()

func mouse_leave() -> CardState:
	return super()

func process_click()-> CardState:
	return hand
