class_name BasicAttack
extends ActionCard

var damage: int

func _ready() -> void:
	super()
	damage = champion.power
	description = 'Deals the base damage of your champion ('+str(damage)+') to a random enemy'


func play() -> bool:
	lock()
	await playing_animation()
	
	var enemy: ChampionCard = get_random_enemy()
	
	enemy.decrease_health(damage)
	parent.pop_card(enemy)
	
	unlock()
	return await super()


func _process(delta: float) -> void:
	pass
