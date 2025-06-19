extends Node3D
class_name GameClass

enum camera_pos {
	START,
	PREV_START
}

@onready
var card_description: Label = $GUI/Control/LblDescription
@onready
var health: Label = $GUI/Control/Health
@onready
var healthL: Label = $GUI/Control/HealthL
@onready
var healthU: Label = $GUI/Control/HealthU
@onready
var healthR: Label = $GUI/Control/HealthR

@onready
var btn_play_card: Button = $GUI/Control/BtnPlayCard

@onready
var champion: ChampionCard = null
@onready
var opponentL: ChampionCard = null
@onready
var opponentU: ChampionCard = null
@onready
var opponentR: ChampionCard = null

const champion_position = Vector3(0,0,0.1)
const opponentL_position = Vector3(1.8,0,0.9)
const opponentU_position = Vector3(0,0,1.7)
const opponentR_position = Vector3(-1.8,0,0.9)

var hand_count = 0
var table_count = 0
var action_deck_count = 0
var support_deck_count = 0
var discard_count = 0

var selected_card: BaseCard

var move_locked = false


func _ready() -> void:
	if Global.sender is ChampionCard:
		var move_duration = 0.7 # seconds
		
		champion = Global.sender 
		$Game.add_child(champion)
		champion.set_default_position(champion_position, move_duration)
		
		opponentL = Global.champion2
		opponentU = Global.champion3
		opponentR = Global.champion4
		
		$Game.add_child(opponentL)
		$Game.add_child(opponentU)
		$Game.add_child(opponentR)
		
		opponentL.set_default_position(opponentL_position, move_duration)
		opponentU.set_default_position(opponentU_position, move_duration)
		opponentR.set_default_position(opponentR_position, move_duration)
		
		set_camera_position(camera_pos.START)
		create_action_cards(25)
		create_support_cards(25)
		
		set_starter_hand()
		btn_play_card.visible = false

func manage_hand_click(card: BaseCard):
	if move_locked:
		return
	
	if table_count >= 1:
		return
	
	selected_card = card
	update_table_count(1)
	update_hand_count(-1,card)
	card.update_table_position(table_count,table_count)
	card_description.text = card.description
	
	if card is ActionCard:
		btn_play_card.visible = true

func manage_table_click(card: BaseCard):
	if move_locked:
		return
	
	if table_count < 1:
		return
		
	selected_card = null
	update_hand_count(1)
	table_count = table_count - 1
	card.update_hand_position(hand_count,hand_count)
	card_description.text = ''
	
	if card is ActionCard:
		btn_play_card.visible = false


func _on_btn_play_card_button_down() -> void:
	if selected_card == null:
		return
	
	await selected_card.play();
	
	handle_discard(selected_card)
	selected_card = null
	
	table_count = table_count - 1
	card_description.text = ''
	btn_play_card.visible = false


func handle_discard(card: BaseCard):
	discard_count = discard_count + 1
	card.discard(discard_count);


func set_starter_hand():
	var i = 1
	hand_count = 6
	while i <= 3:
		var card = get_card_from_action_deck()
		action_deck_count = action_deck_count-1
		card.update_hand_position(i,hand_count)
		i = i+1
	
	while i <= 6:
		var card = get_card_from_support_deck()
		support_deck_count = support_deck_count-1
		card.update_hand_position(i,hand_count)
		i = i+1

func manage_deck_click(sender: BaseCard):
	if lock and move_locked:
		return
	
	var card
	if sender is ActionCard:
		card = get_card_from_action_deck()
		action_deck_count = action_deck_count-1
	else:
		card = get_card_from_support_deck()
		support_deck_count = support_deck_count-1
	
	update_hand_count(1)
	card.update_hand_position(hand_count,hand_count)


func get_action_card() -> ActionCard:
	match randi_range(1,2):
		1:	return Global.basic_attack_scene.instantiate()
		_:	return Global.opportunity_attack_scene.instantiate()


func get_support_card() -> SupportCard:
	match randi_range(1,2):
		1:	return Global.parry_scene.instantiate()
		_:	return Global.protector_shield_scene.instantiate()


func show_enemy(card: BaseCard):
	card.on_mouse_entered()
	await get_tree().create_timer(0.35).timeout
	card.on_mouse_exited()
	await get_tree().create_timer(0.35).timeout


func _process(delta: float) -> void:
	if champion:
		health.text = str(champion.health)+"/"+str(champion.max_health) + "\n" + str(champion.mana)+"/"+str(champion.max_mana)
	if opponentL:
		healthL.text = str(opponentL.health)+"/"+str(opponentL.max_health) + "\n" + str(opponentL.mana)+"/"+str(opponentL.max_mana)
	if opponentU:
		healthU.text = str(opponentU.health)+"/"+str(opponentU.max_health) + "\n" + str(opponentU.mana)+"/"+str(opponentU.max_mana)
	if opponentR:
		healthR.text = str(opponentR.health)+"/"+str(opponentR.max_health) + "\n" + str(opponentR.mana)+"/"+str(opponentR.max_mana)

func get_card_from_action_deck() -> BaseCard:
	for card in $Game.get_children():
		if card is ActionCard and card.state == BaseCard.IN_DECK:
			if card.deck_position == action_deck_count-1:
				return card
	return null


func get_card_from_support_deck() -> BaseCard:
	for card in $Game.get_children():
		if card is SupportCard and card.state == BaseCard.IN_DECK:
			if card.deck_position == support_deck_count-1:
				return card
	return null


func create_action_cards(ammount: int):
	action_deck_count = ammount
	for i in range(ammount):
		var card = get_action_card()
		card.state = BaseCard.IN_DECK
		card.set_deck_position(i)
		$Game.add_child(card)


func create_support_cards(ammount: int):
	support_deck_count = ammount
	for i in range(ammount):
		var card = get_support_card()
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
