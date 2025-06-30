class_name OpportunityAttack
extends ActionCard

var damage: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	damage = champion.power * 2
	description = 'Deals DOUBLE the base damage of your champion ('+str(damage)+') to a random enemy'


func play() -> bool:
	lock()
	await playing_animation()
	
	var enemy: ChampionCard = get_random_enemy()
	
	enemy.decrease_health(damage)
	parent.pop_card(enemy)
	
	unlock()
	return await super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
