class_name OpportunityAttack
extends ActionCard

var damage: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	if actor:
		damage = actor.champion.power * 2
	else:
		damage = 0


func play() -> bool:
	lock()
	await playing_animation()
	damage = actor.champion.power * 2
	var enemy: ChampionCard = Global.get_random_enemy(actor.champion)
	
	actor.champion.attack(enemy,damage)
	parent.pop_card(enemy)
	
	unlock()
	return await super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if actor:
		description = 'Deals DOUBLE the base damage of your champion ('+str(actor.champion.power * 2)+') to a random enemy'
