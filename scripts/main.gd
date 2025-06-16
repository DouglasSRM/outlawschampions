extends Node3D
class_name GameClass

enum camera_pos {
	START,
	PREV_START
}

@onready
var health = $GUI/Control/Health
@onready
var champion = $Game/Champion

const DRUIDA = "res://images/druida.png"
const LADINO = "res://images/ladino.png"
const MAGO = "res://images/mago.png"
const PALADINO = "res://images/paladino.png"

const base_card_scene = preload("res://scenes/base_card.tscn")

var hand_count = 0
var table_count = 0
var deck_count = 0

var move_locked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	champion.set_texture(load(MAGO))
	set_camera_position(camera_pos.START)
	create_cards(15)
	$Game/BaseCard5.set_texture(load(LADINO))
	$Game/BaseCard7.set_texture(load(DRUIDA))
	$Game/BaseCard8.set_texture(load(PALADINO))

func manage_hand_click(card: BaseCard):
	if move_locked:
		return
	
	update_table_count(1)
	update_hand_count(-1,card)
	card.update_table_position(table_count,table_count)

func manage_deck_click():
	if move_locked:
		return
		
	var card = get_card_from_deck()
	deck_count = deck_count-1
	update_hand_count(1)
	card.update_hand_position(hand_count,hand_count)
	card.set_texture(load(get_random_card()))

func get_random_card() -> String: 
	match randi_range(1,4):
		1: return DRUIDA
		2: return LADINO
		3: return MAGO
		_: return PALADINO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	health.text = str(champion.health)+"/"+str(champion.max_health)

func get_card_from_deck() -> BaseCard:
	for card in $Game.get_children():
		if card is BaseCard and card.state == BaseCard.IN_DECK:
			if card.deck_position == deck_count-1:
				return card
	return null

func create_cards(ammount: int):
	print('creating')
	deck_count = ammount
	for i in range(ammount):
		var card = base_card_scene.instantiate()
		card.state = BaseCard.IN_DECK
		card.set_deck_position(i)
		$Game.add_child(card)

func update_table_count(count: int) -> bool:
	table_count = table_count + count
	print('table ',table_count)
	for card in $Game.get_children():
		if card is BaseCard and card.state == BaseCard.IN_TABLE:
			card.update_table_position(0, table_count)
	return true

func update_hand_count(count: int, removed_card: BaseCard = null) -> bool:
	hand_count = hand_count + count
	print('hand ',hand_count)
	for card in $Game.get_children():
		if card is BaseCard and card.state == BaseCard.IN_HAND:
			if (removed_card == card):
				continue
			if (removed_card == null) or (card.hand_position < removed_card.hand_position):
				card.update_hand_position(0, hand_count)
			else:
				card.update_hand_position(card.hand_position-1, hand_count)
	return true

func set_card_states(state: int) -> void:
	for card in $Game.get_children():
		if card is BaseCard:
			card.state = state
	
func lock():
	move_locked = true
	
func unlock():
	move_locked = false

func set_camera_position(pos):
	match pos: 
		camera_pos.START:
			$Game/Camera.position = Vector3(0, 3, 0)
			$Game/Camera.rotation = Vector3(deg_to_rad(-90), deg_to_rad(-180), 0.0)
		camera_pos.PREV_START:
			$Game/Camera.position = Vector3(0.0, 2.6, -7.8)
			$Game/Camera.rotation = Vector3(-0.785398, -3.141593, 0.0)
	#banana
	
