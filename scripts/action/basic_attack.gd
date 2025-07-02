class_name BasicAttack
extends ActionCard

var damage: int

func _ready() -> void:
	super()
	if actor:
		damage = actor.champion.power
	else:
		damage = 0


func play() -> bool:
	lock()
	await playing_animation()
	damage = actor.champion.power
	
	var enemy: ChampionCard = get_random_enemy()
	
	enemy.decrease_health(damage)
	parent.pop_card(enemy)
	
	unlock()
	return await super()


func _process(delta: float) -> void:
	if actor:
		description = 'Deals the base damage of your champion ('+str(actor.champion.power)+') to a random enemy'
