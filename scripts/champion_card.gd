class_name ChampionCard
extends BaseCard

enum hStatus {
	FULL,
	HALF,
	DYING
}

var health_status = hStatus.FULL
var max_health: int
var health: int
var power: int
var max_mana: int
var mana: int

func decrease_health(value):
	health = max(0, health - value)
	
	update_status()

func attack(champion: ChampionCard, damage := power):
	champion.decrease_health(damage)

func update_status():
	match health:
		0: health_status = hStatus.DYING

func select():
	Global.sender = self
	get_parent().get_parent().change_scene()

func _ready() -> void:
	state = CHAMPION


func _process(delta: float) -> void:
	pass
