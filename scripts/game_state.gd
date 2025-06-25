class_name GameState
extends Node

var parent: GameScene

func enter() -> void:
	pass

func exit() -> void:
	pass

func allow_hand_click(card: BaseCard) -> bool:
	return false

func handle_hover(card: BaseCard) -> bool:
	return false

func handle_play_button() -> GameState:
	return null

func start_game() -> GameState:
	return null

func process_action_deck_click() -> GameState:
	return null

func process_support_deck_click() -> GameState:
	return null
