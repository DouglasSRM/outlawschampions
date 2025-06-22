class_name GameScene
extends Node3D

enum camera_pos {
	START,
	PREV_START
}

@onready var cards: Node = $Game/Cards

@onready var camera: Camera3D = $Game/Camera

@onready var lbl_card_description: Label = $GUI/Control/LblDescription
@onready var health: Label = $GUI/Control/Health
@onready var healthL: Label = $GUI/Control/HealthL
@onready var healthU: Label = $GUI/Control/HealthU
@onready var healthR: Label = $GUI/Control/HealthR

@onready var btn_play_card: Button = $GUI/Control/BtnPlayCard

@onready var champion: ChampionCard = null
@onready var opponentL: ChampionCard = null
@onready var opponentU: ChampionCard = null
@onready var opponentR: ChampionCard = null

const champion_position = Vector3(0,0,0.1)
const opponentL_position = Vector3(1.8,0,0.9)
const opponentU_position = Vector3(0,0,1.7)
const opponentR_position = Vector3(-1.8,0,0.9)

@export var hand_count: int = 0
@export var table_count: int = 0
@export var action_deck_count: int = 0
@export var support_deck_count: int = 0
@export var discard_count: int = 0

var selected_card: BaseCard
var move_locked = false


func _ready() -> void:
	if Global.player_champion is ChampionCard:
		define_champion_positions()
		
		set_camera_position(camera_pos.START)
		create_action_cards(100)
		create_support_cards(100)
		
		set_starter_hand()
		btn_play_card.visible = false


func set_starter_hand():
	self.hand_count = 6
	
	var i = 1
	
	# Game starts with 3 action cards and 3 support cards in the player's hand
	while i <= self.hand_count:
		var card
		
		if i % 2 == 0:
			card = get_card_from_action_deck()
		else:
			card = get_card_from_support_deck()
		
		card.hand_position = i
		card.click()
		i += 1


func manage_deck_click(sender: BaseCard) -> BaseCard:
	if self.move_locked:
		return
	
	if sender is ActionCard:
		return get_card_from_action_deck()
	elif sender is SupportCard:
		return get_card_from_support_deck()
	else:
		return null


func show_enemy(card: ChampionCard):
	card.on_mouse_entered()
	await get_tree().create_timer(0.35).timeout
	card.on_mouse_exited()
	await get_tree().create_timer(0.35).timeout


func get_card_from_action_deck() -> BaseCard:
	for card in get_cards(BaseCard.IN_DECK):
		if card is ActionCard and (card.deck_position == action_deck_count-1):
			action_deck_count -= 1
			return card
	return null


func get_card_from_support_deck() -> BaseCard:
	for card in get_cards(BaseCard.IN_DECK):
		if (card is SupportCard) and (card.deck_position == support_deck_count-1):
			support_deck_count -= 1
			return card
	return null


func create_action_cards(ammount: int):
	action_deck_count += ammount
	for i in range(action_deck_count):
		var card = get_action_card()
		card.parent = self
		card.state = BaseCard.IN_DECK
		card.set_deck_position(i)
		cards.add_child(card)


func create_support_cards(ammount: int):
	support_deck_count += ammount
	for i in range(support_deck_count):
		var card = get_support_card()
		card.parent = self
		card.state = BaseCard.IN_DECK
		card.set_deck_position(i)
		cards.add_child(card)


func get_action_card() -> ActionCard:
	match randi_range(1,2):
		1:	return Global.basic_attack_scene.instantiate()
		_:	return Global.opportunity_attack_scene.instantiate()


func get_support_card() -> SupportCard:
	match randi_range(1,2):
		1:	return Global.parry_scene.instantiate()
		_:	return Global.protector_shield_scene.instantiate()


func manage_hand_click(card: BaseCard):
	if self.move_locked:
		return
	
	if table_count >= 1:
		return
	
	selected_card = card
	update_table_count(1)
	update_hand_count(-1,card)
	card.update_table_position(table_count,table_count)
	card.click()
	lbl_card_description.text = card.description
	
	if card is ActionCard:
		btn_play_card.visible = true


func manage_table_click(card: BaseCard):
	if (self.move_locked) or (table_count < 1):
		return
	
	selected_card = null
	update_hand_count(1)
	update_table_count(-1)
	card.click()
	#update_hand_position(hand_count,hand_count)
	lbl_card_description.text = ''
	
	if card is ActionCard:
		btn_play_card.visible = false


func update_table_count(count: int) -> bool:
	table_count += count

	for card in get_cards(BaseCard.IN_TABLE):
		card.update_table_position(0, table_count)
	return true


func update_hand_count(count: int, removed_card: BaseCard = null) -> bool:
	hand_count += count
	
	for card in get_cards(BaseCard.IN_HAND):
		if (removed_card == card):
			continue
			
		if (removed_card != null) and (card.hand_position > removed_card.hand_position):
			card.hand_position -= 1
		
		card.update()
		
		#if (removed_card == null) or (card.hand_position < removed_card.hand_position):
			#card.update_hand_position(0, hand_count)
		#else:
			#card.update_hand_position(card.hand_position-1, hand_count)
	return true


func _on_btn_play_card_button_down() -> void:
	if selected_card == null:
		return
	
	btn_play_card.visible = false
	await selected_card.play();
	
	handle_discard(selected_card)
	selected_card = null
	lbl_card_description.text = ''


func handle_discard(card: BaseCard):
	if card.state == BaseCard.IN_TABLE:
		table_count -= 1
	
	discard_count += 1
	card.discard(discard_count)


func get_cards(state: int) -> Array[BaseCard]:
	var result: Array[BaseCard] = []
	
	for card in cards.get_children():
		if card.state == state:
			result.append(card)
	
	return result


func define_champion_positions():
	var move_duration = 0.7 # seconds
	
	champion = Global.player_champion 
	cards.add_child(champion)
	champion.set_default_position(champion_position, move_duration)
	champion.parent = self
	
	opponentL = Global.enemy_1
	opponentU = Global.enemy_2
	opponentR = Global.enemy_3
	
	opponentL.parent = self
	opponentU.parent = self
	opponentR.parent = self
	
	cards.add_child(opponentL)
	cards.add_child(opponentU)
	cards.add_child(opponentR)
	
	opponentL.set_default_position(opponentL_position, move_duration)
	opponentU.set_default_position(opponentU_position, move_duration)
	opponentR.set_default_position(opponentR_position, move_duration)


func lock():
	self.move_locked = true
	
func unlock():
	self.move_locked = false


func set_camera_position(pos):
	match pos:
		camera_pos.START:
			camera.position = Vector3(0, 3, 0)
			camera.rotation = Vector3(deg_to_rad(-90), deg_to_rad(-180), 0.0)


func _process(_delta: float) -> void:
	if champion:
		health.text = str(champion.health)+"/"+str(champion.max_health) + "\n" + str(champion.mana)+"/"+str(champion.max_mana)
	if opponentL:
		healthL.text = str(opponentL.health)+"/"+str(opponentL.max_health) + "\n" + str(opponentL.mana)+"/"+str(opponentL.max_mana)
	if opponentU:
		healthU.text = str(opponentU.health)+"/"+str(opponentU.max_health) + "\n" + str(opponentU.mana)+"/"+str(opponentU.max_mana)
	if opponentR:
		healthR.text = str(opponentR.health)+"/"+str(opponentR.max_health) + "\n" + str(opponentR.mana)+"/"+str(opponentR.max_mana)
