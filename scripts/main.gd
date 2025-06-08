extends Node3D

const DRUIDA = "res://images/druida.png"
const LADINO = "res://images/ladino.png"
const MAGO = "res://images/mago.png"
const PALADINO = "res://images/paladino.png"

const base_card_scene = preload("res://scenes/base_card.tscn")

var hand_count = 0

var deck_locked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set_card_states(BaseCard.IN_DECK)
	create_cards(15)

func manage_deck_click(card: BaseCard):
	if deck_locked:
		return
	
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

func create_cards(ammount: int):
	print('creating')
	for i in range(ammount):
		var card = base_card_scene.instantiate()
		card.state = BaseCard.IN_DECK
		card.set_deck_position(i)
		add_child(card)

func update_hand_count(count: int) -> bool:
	hand_count = hand_count + count
	print('hand ',hand_count)
	for card in get_children():
		if card is BaseCard and card.state == BaseCard.IN_HAND:
			card.update_hand_position(0, hand_count)
	return true
	

func set_card_states(state: int) -> void:
	for card in get_children():
		if card is BaseCard:
			card.state = state
	
func deck_lock():
	deck_locked = true
	
func deck_unlock():
	deck_locked = false
