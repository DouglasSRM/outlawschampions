class_name GameStateMachine
extends Node

@onready var starting_state: GameState = $Loading

var current_state: GameState

func init(parent: GameScene) -> void:
	for child in get_children():
		child.parent = parent
	
	change_state(starting_state)


func change_state(new_state: GameState) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()


func process_action_deck_click() -> bool:
	var new_state = current_state.process_action_deck_click()
	if new_state:
		change_state(new_state)
		return true
	return false


func process_support_deck_click() -> bool:
	print(current_state)
	var new_state = current_state.process_support_deck_click()
	if new_state:
		change_state(new_state)
		return true
	return false


func start_game() -> void:
	var new_state = current_state.start_game()
	if new_state:
		change_state(new_state)
