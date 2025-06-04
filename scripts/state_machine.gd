class_name CardStateMachine
extends Node

@export var starting_state: CardState

var current_state: CardState


func init(parent: BaseCard, state: CardState = null) -> void:
	print('a')
	for child in get_children():
		child.parent = parent
	
	if state != null:
		print('a')
		starting_state = state
	
	change_state(starting_state)


func change_state(new_state: CardState) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()


func update() -> void:
	current_state.update()


func mouse_enter() -> void:
	var new_state = current_state.mouse_enter()
	if new_state:
		change_state(new_state)

func mouse_leave() -> void:
	var new_state = current_state.mouse_leave()
	if new_state:
		change_state(new_state)

func process_click() -> void:
	print(current_state)
	var new_state = current_state.process_click()
	if new_state:
		change_state(new_state)
	
	print(current_state)
