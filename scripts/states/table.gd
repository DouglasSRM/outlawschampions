extends CardState

@onready var hand: CardState = $"../Hand"

func enter() -> void:
	pass


func exit() -> void:
	parent.table_position = 0

func mouse_enter() -> CardState:
	return super()

func mouse_leave() -> CardState:
	return super()

func process_click()-> CardState:
	return hand
