class_name CardState
extends Node

var card: BaseCard

func enter() -> void:
	pass

func exit() -> void:
	pass

func update() -> void:
	pass

func equip() -> CardState:
	return null

func mouse_enter() -> CardState:
	return null

func mouse_leave() -> CardState:
	return null

func process_click() -> CardState:
	return null

func handle_click() -> CardState:
	return null

func try_exit_hover():
	var old_pos = card.default_position
	var old_state = card.state
	while !card.can_hover():
		await get_tree().create_timer(1).timeout
	if card.default_position == old_pos and card.state == old_state:
		card.do_exit_hover_animation()
