class_name GameScene
extends Node3D

enum camera_pos {
	START
}

signal loaded

@onready var cards: Node = $Game/Cards

@onready var player_positions: Node = $Game/PositionComponents/PlayerPositions

@onready var camera: Camera3D = $Game/Camera

@onready var lbl_card_description: Label = $GUI/Control/LblDescription
@onready var health: Label = $GUI/Control/Health
@onready var healthL: Label = $GUI/Control/HealthL
@onready var healthU: Label = $GUI/Control/HealthU
@onready var healthR: Label = $GUI/Control/HealthR

@onready var btn_play_card: Button = $GUI/Control/BtnPlayCard

@onready var state_machine: GameStateMachine = $StateMachine

@onready var champion: ChampionCard = null
@onready var opponentL: ChampionCard = null
@onready var opponentU: ChampionCard = null
@onready var opponentR: ChampionCard = null

const champion_position = Vector3(0,0,0.1)
const opponentL_position = Vector3(1.8,0,0.9)
const opponentU_position = Vector3(0,0,1.7)
const opponentR_position = Vector3(-1.8,0,0.9)

@export var hand_count: int = 0
@export var action_deck_count: int = 0
@export var support_deck_count: int = 0
var table_count: int = 5
var discard_count: int = 0

## How many support cards can the player currently buy
var can_buy_support: int = 0
## How many action cards can the player currently buy
var can_buy_action: int = 0

var selected_card: BaseCard
var move_locked = false


func _ready() -> void:
	state_machine.init(self)


func _on_loaded() -> void:
	state_machine.start_game()


func set_starter_hand():
	if hand_count == 0:
		hand_count = 6
	
	var i = 1
	
	while i <= self.hand_count:
		var card
		
		if i % 2 == 0:
			card = get_card_from_action_deck()
		else:
			card = get_card_from_support_deck()
		
		card.hand_position = i
		card.go_to_hand()
		i += 1


func allow_hand_click(card: BaseCard) -> bool:
	return state_machine.allow_hand_click(card)


func manage_deck_click(sender: BaseCard) -> BaseCard:
	if self.move_locked:
		return
	
	if sender is ActionCard:
		return process_action_deck_click()
	elif sender is SupportCard:
		return process_support_deck_click()
	else:
		return null


func process_action_deck_click() -> ActionCard:
	if state_machine.process_action_deck_click():
		return get_card_from_action_deck()
	return null


func process_support_deck_click() -> SupportCard:
	if state_machine.process_support_deck_click():
		return get_card_from_support_deck()
	return null


func get_card_from_action_deck() -> ActionCard:
	for card in get_cards(BaseCard.IN_DECK):
		if card is ActionCard and (card.deck_position == action_deck_count):
			return card
	return null


func get_card_from_support_deck() -> SupportCard:
	for card in get_cards(BaseCard.IN_DECK):
		if (card is SupportCard) and (card.deck_position == support_deck_count):
			return card
	return null


func create_action_cards():
	if action_deck_count == 0:
		action_deck_count = 25 #default
	
	for i in range(1,action_deck_count+1):
		var card = create_action_card()
		card.parent = self
		card.deck_position = i
		cards.add_child(card)


func create_support_cards():
	if support_deck_count == 0:
		support_deck_count = 25 #default
	
	for i in range(1,support_deck_count+1):
		var card = create_support_card()
		card.parent = self
		card.deck_position = i
		cards.add_child(card)


func create_action_card() -> ActionCard:
	match randi_range(1,2):
		1:	return Global.basic_attack_scene.instantiate()
		_:	return Global.opportunity_attack_scene.instantiate()


func create_support_card() -> SupportCard:
	match randi_range(1,2):
		1:	return Global.parry_scene.instantiate()
		_:	return Global.protector_shield_scene.instantiate()


func manage_hand_click(card: BaseCard) -> bool:
	if self.move_locked:
		return false
	
	if selected_card:
		update_hand_count(0, card)
		selected_card.go_to_hand()
	else:
		update_hand_count(-1,card)
	
	return true


func select_card(card: BaseCard):
	selected_card = card
	lbl_card_description.text = card.description
	btn_play_card.visible = true


func manage_table_click(card: BaseCard) -> bool:
	if (self.move_locked) or (table_count < 1):
		return false
	
	selected_card = null
	update_hand_count(1)
	
	lbl_card_description.text = ''
	btn_play_card.visible = false
		
	return true


func update_table_count(count: int):
	table_count += count
	
	for card in get_cards(BaseCard.IN_TABLE):
		card.update()


func update_hand_count(count: int, removed_card: BaseCard = null):
	hand_count += count
	
	for card in get_cards(BaseCard.IN_HAND):
		if (removed_card == card):
			continue
		
		if (removed_card != null) and (card.hand_position > removed_card.hand_position):
			card.hand_position -= 1
		
		card.update()


func play_card() -> bool:
	if selected_card == null:
		return false
	
	btn_play_card.visible = false
	await selected_card.play();
	
	selected_card = null
	lbl_card_description.text = ''
	
	return true


func _on_btn_play_card_button_down() -> void:
	state_machine.handle_play_button()


func manage_hover(card: BaseCard) -> bool:
	return state_machine.handle_hover(card)


func pop_card(card: BaseCard):
	card.do_hover_animation()
	await get_tree().create_timer(0.35).timeout
	card.do_exit_hover_animation()
	await get_tree().create_timer(0.35).timeout


func handle_equip(card: BaseCard):
	card.equip()


func handle_discard(card: BaseCard):
	discard_count += 1
	card.discard()


func set_player_positions():
	for card in get_cards(BaseCard.IN_DECK):
		card.set_position_component(player_positions.duplicate())


func get_cards(state: int) -> Array[BaseCard]:
	var result: Array[BaseCard] = []
	
	for card in cards.get_children():
		if card.state == state:
			result.append(card)
	
	return result


func define_champion_positions():
	champion = Global.player_champion 
	cards.add_child(champion)
	champion.parent = self
	champion.default_position = champion_position
	champion.set_champion_state()
	
	opponentL = Global.enemy_1
	opponentU = Global.enemy_2
	opponentR = Global.enemy_3
	
	cards.add_child(opponentL)
	cards.add_child(opponentU)
	cards.add_child(opponentR)
	
	opponentL.parent = self
	opponentU.parent = self
	opponentR.parent = self
	
	opponentL.default_position = opponentL_position
	opponentU.default_position = opponentU_position
	opponentR.default_position = opponentR_position
	
	opponentL.set_champion_state()
	opponentU.set_champion_state()
	opponentR.set_champion_state()


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
