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
	EQUIPED,
	IN_DISCARD
}

@onready var parent: Node3D
@onready var state_machine: CardStateMachine = $StateMachine
@onready var discard_state: Node = $StateMachine/Discard
@onready var hand: Node = $StateMachine/Hand

@export var description: String = 'Default description'

var actor: Actor
var position_component: PostionComponent

var state           : int = NONE
var hand_position   : int = 0
var table_position  : int = 0
var deck_position   : int = 0
var discard_position: int = 0

var hover: bool = false
var default_position: Vector3 = Vector3(0,0,0)
var hover_position  : Vector3 = Vector3(0,0,0)


func current_actor() -> Actor:
	return parent.current_actor


func set_actor(actor: Actor = null):
	if actor:
		self.actor = actor
	else:
		self.actor = current_actor()
	
	set_position_component(self.actor.position_component)


func set_position_component(component: PostionComponent):
	self.position_component = component.duplicate()
	self.position_component.card = self


func _ready() -> void:
	if !position_component:
		set_position_component($PositionComponent)


func handle_table_click() -> bool:
	return parent.manage_table_click(self)


func handle_hand_click() -> bool:
	if parent.allow_hand_click(self):
		return parent.manage_hand_click(self)
	return false


func equip():
	state_machine.equip()


func update():
	state_machine.update()


func click():
	state_machine.process_click()


func go_to_hand():
	state_machine.change_state(hand)


func can_hover() -> bool:
	if !is_locked_for_movement():
		return parent.manage_hover(self)
	return false


func _on_mouse_entered() -> void:
	if parent.manage_hover(self):
		state_machine.mouse_enter()


func _on_mouse_exited() -> void:
	if parent.manage_hover(self):
		state_machine.mouse_leave()


func deck_click():
	var card: BaseCard = await parent.manage_deck_click(self)
	if card: card.click()


func discard():
	state_machine.change_state(discard_state)


func play() -> bool:
	return true


func get_table_count() -> int:
	return actor.table_count;


func get_hand_count() -> int:
	return actor.hand_count;


func get_discard_count() -> int:
	return parent.discard_count;


func update_hover_position(hover_height: float = 0.7):
	const X_FACTOR = 0.33
	const Z_FACTOR = 0.34
	
	hover_position = Vector3(
		default_position.x * (1.0 - X_FACTOR * hover_height),
		default_position.y + hover_height,
		default_position.z * (1.0 - Z_FACTOR * hover_height)
	)


func select():
	parent.select_card(self)


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
	update_hover_position()


func move_to_position(target_position: Vector3, duration: float):
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished


func move_state(new_state, target_position: Vector3 = default_position):
	lock()
	var duration = 0.5
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	state = new_state
	unlock()
