class_name BaseCard
extends Node3D

## The base card object used to structure base properties and methods
## for champions and usable cards.

enum {
	NONE,
	SELECT,
	CHAMPION,
	IN_DECK,
	IN_HAND,
	IN_TABLE,
	IN_DISCARD
}

@onready var parent: Node3D
@onready var state_machine: CardStateMachine = $StateMachine
@onready var discard_state: Node = $StateMachine/Discard

@export var description: String = 'Default description'

var state           : int = NONE
var hand_position   : int = 0
var table_position  : int = 0
var deck_position   : int = 0
var discard_position: int = 0

var hover: bool = false
var default_position: Vector3 = Vector3(0,0,0)
var hover_position  : Vector3 = Vector3(0,0,0)


func handle_table_click() -> bool:
	return parent.manage_table_click(self)


func handle_hand_click() -> bool:
	return parent.manage_hand_click(self)


func update():
	state_machine.update()


func click():
	state_machine.process_click()


func _on_mouse_entered() -> void:
	state_machine.mouse_enter()


func _on_mouse_exited() -> void:
	state_machine.mouse_leave()


func deck_click():
	var card: BaseCard = parent.manage_deck_click(self)
	if card:
		parent.update_hand_count(1)
		card.click()


func discard():
	state_machine.change_state(discard_state)


func play() -> bool:
	await get_tree().create_timer(0.7).timeout
	return true


func get_table_count() -> int:
	return parent.table_count;
	

func get_hand_count() -> int:
	return parent.hand_count;


func get_discard_count() -> int:
	return parent.discard_count;


func update_hover_position(pos: Vector3 = position):
	var pos_x = (pos[0] / 4) * 3.07
	var pos_y = 0.7  
	var pos_z = pos[2] - (pos[2] / 4.23)
	
	hover_position = Vector3(pos_x, pos_y, pos_z)


func move_state(target_position: Vector3, new_state):
	lock()
	
	var duration = 0.5
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
	state = new_state
	
	unlock()


func select():
	pass


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		match state:
			IN_DECK: deck_click() # When any card of the deck is clicked, the click event will be executed for the first card of the deck.
			_: click()


func is_locked_for_movement() -> bool:
	if parent:
		return parent.move_locked
	return true


func lock() -> void:
	if parent:
		parent.lock()


func unlock() -> void:
	if parent:
		parent.unlock()


func do_hover_animation() -> void:
	hover = true
	move_to_position(hover_position, 0.2)


func do_exit_hover_animation() -> void:
	hover = false
	move_to_position(Vector3(default_position), 0.2)


func set_default_position(pos: Vector3 = position):
	self.default_position = pos
	update_hover_position(pos)


func move_to_position(target_position: Vector3, duration: float):
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
