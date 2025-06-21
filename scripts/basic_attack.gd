class_name BasicAttack
extends ActionCard

var damage: int

func _ready() -> void:
	super()
	damage = champion.power
	description = 'Deals the base damage of your champion ('+str(damage)+') to a random enemy'


func play() -> bool:
	var enemy: ChampionCard
	match randi_range(1,3):
		1: enemy = Global.enemy_1
		2: enemy = Global.enemy_2
		_: enemy = Global.enemy_3
	
	enemy.decrease_health(damage)
	parent.show_enemy(enemy)
	
	return await super()


func _process(delta: float) -> void:
	pass
