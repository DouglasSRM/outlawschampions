class_name GameScene
extends Node3D

enum camera_pos {
	START
}

signal loaded

@onready var cards: Node = $Game/Cards
@onready var actors: Node = $Game/Actors
@onready var camera: Camera3D = $Game/Camera

@onready var lbl_card_description: Label = $GUI/Control/LblDescription
@onready var health: Label = $GUI/Control/Health

@onready var btn_play_card: Button = $GUI/Control/BtnPlayCard

@onready var state_machine: GameStateMachine = $StateMachine

@onready var champion: ChampionCard = null

var current_actor: Actor
var round: int = -1

const champion_position = Vector3(0,0,0.1)

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


func start_enemy_loop():
	await get_tree().create_timer(0.5).timeout
	process_support_deck_click().execute_click()
	await get_tree().create_timer(1).timeout
	get_random_sup_card_in_hand().execute_click()
	await get_tree().create_timer(0.5).timeout
	state_machine.handle_play_button()
	await get_tree().create_timer(1).timeout
	
	if current_actor.champion.mana == current_actor.champion.special_mana:
		await current_actor.champion.execute_click()
	else:
		var card = await process_action_deck_click()
		await get_tree().create_timer(0.5).timeout
		card.execute_click()


func check_effects() -> void:
	for champion in Global.all_champions:
		await champion.execute_effects()


func get_random_sup_card_in_hand() -> SupportCard:
	var sup_cards: Array = get_cards(BaseCard.IN_HAND, false)
	sup_cards.shuffle()
	for card in sup_cards:
		if card is SupportCard:
			return card
	return null


func _on_loaded() -> void:
	next_round()


func is_player_turn() -> bool:
	return current_actor.champion == Global.player_champion


func define_current_actor(i: int = 0):
	self.current_actor = actors.get_child(i)


func get_actors_count() -> int:
	return actors.get_children().size()


func next_round():
	await check_effects()
	
	var old_actor = self.current_actor
	
	self.round += 1
	var size = get_actors_count()
	define_current_actor(round % size)
	
	while self.current_actor.champion.health_status == ChampionCard.hStatus.DEAD:
		self.round += 1
		define_current_actor(round % size)
	
	if old_actor != self.current_actor:
		state_machine.start_round()
	else:
		end()


func can_use_special() -> bool:
	return state_machine.can_use_special()


func manage_champion_click() -> void:
	state_machine.manage_champion_click()


func _on_btn_restart_button_up() -> void:
	end()


func end():
	get_tree().change_scene_to_file("res://scenes/start.tscn")


func set_starter_hands():
	for actor in actors.get_children():
		set_starter_hand(actor)


func set_starter_hand(actor: Actor):
	if actor.hand_count == 0:
		actor.hand_count = 6
	
	var i = 1
	
	while i <= actor.hand_count:
		var card: BaseCard
		
		if i % 2 == 0:
			card = get_card_from_action_deck()
		else:
			card = get_card_from_support_deck()
		
		card.set_actor(actor)
		card.hand_position = i
		card.go_to_hand()
		i += 1


func allow_hand_click(card: BaseCard) -> bool:
	return state_machine.allow_hand_click(card)


func manage_deck_click(sender: BaseCard) -> BaseCard:
	if self.move_locked:
		return null
	
	if !is_player_turn():
		return null
	
	if sender is ActionCard:
		return await process_action_deck_click()
	elif sender is SupportCard:
		return process_support_deck_click()
	else:
		return null


func process_action_deck_click() -> ActionCard:
	if await state_machine.process_action_deck_click():
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
		action_deck_count = 70 #default
	
	for i in range(1,action_deck_count+1):
		var card = create_action_card()
		card.parent = self
		card.deck_position = i
		cards.add_child(card)


func create_support_cards():
	if support_deck_count == 0:
		support_deck_count = 70 #default
	
	for i in range(1,support_deck_count+1):
		var card = create_support_card()
		card.parent = self
		card.deck_position = i
		cards.add_child(card)


func create_action_card() -> ActionCard:
	match randi_range(1,4):
		1:	return Global.basic_attack_scene.instantiate()
		2:	return Global.opportunity_attack_scene.instantiate()
		3:	return Global.powerful_attack_scene.instantiate()
		_:	return Global.lilting_attack_scene.instantiate()

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
	if is_player_turn():
		lbl_card_description.text = card.description
		btn_play_card.visible = true


func manage_table_click(card: BaseCard) -> bool:
	if (self.move_locked) or (current_actor.table_count < 1):
		return false
	
	selected_card = null
	update_hand_count(1)
	
	lbl_card_description.text = ''
	btn_play_card.visible = false
		
	return true


func update_table_count(count: int):
	current_actor.table_count += count
	
	for card in get_cards(BaseCard.IN_TABLE, false):
		card.update()


func update_hand_count(count: int, removed_card: BaseCard = null):
	current_actor.hand_count += count
	
	for card in get_cards(BaseCard.IN_HAND, false):
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
	if !is_inside_tree():
		return
	card.update_hover_position(0.3)
	card.do_hover_animation()
	await get_tree().create_timer(0.35).timeout
	if card.position == card.hover_position:
		card.do_exit_hover_animation()
		await get_tree().create_timer(0.2).timeout
		card.update_hover_position()


func handle_equip(card: BaseCard):
	card.equip()


func handle_discard(card: BaseCard):
	discard_count += 1
	card.discard()


func get_cards(state: int, all: bool = true) -> Array[BaseCard]:
	var result: Array[BaseCard] = []
	
	for card in cards.get_children():
		if (card.state == state and (all or card.actor == self.current_actor)):
			result.append(card)
	
	return result


func define_champion_positions():
	champion = Global.player_champion 
	cards.add_child(champion)
	champion.parent = self
	champion.default_position = champion_position
	champion.set_champion_state()


func lock():
	self.move_locked = true


func unlock():
	self.move_locked = false


func set_camera_position(pos):
	match pos:
		camera_pos.START:
			camera.position = Vector3(0, 3, 0)
			camera.rotation = Vector3(deg_to_rad(-90), deg_to_rad(-180), 0.0)
