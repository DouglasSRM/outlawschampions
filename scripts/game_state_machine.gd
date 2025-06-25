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


func allow_hand_click(card: BaseCard) -> bool:
	return current_state.allow_hand_click(card)


func handle_hover(card: BaseCard) -> bool:
	return current_state.handle_hover(card)


func handle_play_button():
	var new_state = current_state.handle_play_button()
	if new_state:
		change_state(new_state)


func process_action_deck_click() -> bool:
	var new_state = current_state.process_action_deck_click()
	if new_state:
		change_state(new_state)
		return true
	return false


func process_support_deck_click() -> bool:
	var new_state = current_state.process_support_deck_click()
	if new_state:
		change_state(new_state)
		return true
	return false


func start_game() -> void:
	var new_state = current_state.start_game()
	if new_state:
		change_state(new_state)
