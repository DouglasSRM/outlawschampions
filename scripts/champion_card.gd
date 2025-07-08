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

func decrease_health(value):
	health = max(0, health - value)
	update_status()

func special_attack():
	pass

func add_mana():
	if mana < max_mana:
		mana += 1

func can_use_special() -> bool:
	return mana >= special_mana and parent.can_use_special()

func attack(champion: ChampionCard, damage := power):
	champion.decrease_health(damage)


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
