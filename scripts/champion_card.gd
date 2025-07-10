class_name ChampionCard
extends BaseCard

enum hStatus {
	FULL,
	HALF,
	DYING,
	DEAD
}

@onready var select_state: Node = $StateMachine/Select
@onready var champion_state: Node = $StateMachine/Champion

var health_status = hStatus.FULL
var max_health: int
var health: int
var power: int
var max_mana: int
var mana: int
var special_mana: int
var current_effects: Array[Effect]

func decrease_health(value):
	health = max(0, health - value)
	update_status()

func special_attack():
	await get_tree().create_timer(0.7).timeout
	parent.next_round()

func on_start_round():
	add_mana()

func add_mana():
	if mana < max_mana:
		mana += 1

func can_use_special() -> bool:
	return mana >= special_mana and parent.can_use_special()

func attack(champion: ChampionCard, damage := power):
	champion.decrease_health(damage)
	apply_passive_attacks(champion)

func apply_passive_attacks(champion: ChampionCard) -> void:
	pass

func execute_effects() -> void:
	for effect in current_effects:
		effect.execute()
		if effect.rounds_left <= 0:
			current_effects.erase(effect)

func apply_effect(effect: Effect) -> void:
	effect.apply(self)
	current_effects.append(effect)

func update_status():
	match health:
		0: health_status = hStatus.DEAD


func set_champion_state():
	state_machine.change_state(champion_state)


func select():
	Global.player_champion = self
	parent.change_scene()


func _ready() -> void:
	if state_machine.current_state == null:
		state_machine.init(self, select_state)
	
	current_effects = []
