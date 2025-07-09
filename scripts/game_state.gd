class_name GameState
extends Node

var parent: GameScene

func enter() -> void:
	pass

func exit() -> void:
	pass

func can_use_special() -> bool:
	return false

func allow_hand_click(card: BaseCard) -> bool:
	return false

func handle_hover(card: BaseCard) -> bool:
	return false

func handle_play_button() -> GameState:
	return null

func start_round() -> GameState:
	return null

func process_action_deck_click() -> GameState:
	return null

func process_support_deck_click() -> GameState:
	return null

func manage_champion_click() -> GameState:
	return null
