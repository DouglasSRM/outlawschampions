class_name LiltingAttack 
extends ActionCard

var damage: int

func _ready() -> void:
	super()
	if actor:
		damage = floor(actor.champion.power / 2)
	else:
		damage = 0

func play() -> bool:
	lock()
	await playing_animation()
	damage = floor(actor.champion.power / 2)
	var enemy: ChampionCard = Global.get_random_enemy(actor.champion)
	
	actor.champion.attack(enemy,damage)
	parent.pop_card(enemy)
	# need adjustmend
	enemy = Global.get_random_enemy(actor.champion)
	actor.champion.attack(enemy,damage)
	parent.pop_card(enemy)
	
	unlock()
	return await super()

func _process(delta: float) -> void:
	if actor:
		description = 'Deals half the base damage of your champion ('+str(floor(actor.champion.power / 2))+') to 2 random enemies'
