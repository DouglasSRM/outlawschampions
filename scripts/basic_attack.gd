class_name BasicAttack
extends ActionCard

@onready
var damage = Global.sender.power

func _ready() -> void:
	description = 'Deals the base damage of your champion ('+str(damage)+') to a random enemy'


func play() -> bool:
	var enemy: ChampionCard
	match randi_range(1,3):
		1: enemy = Global.champion2
		2: enemy = Global.champion3
		_: enemy = Global.champion4
	
	enemy.decrease_health(damage)
	parent.show_enemy(enemy)
	
	return await super()


func _process(delta: float) -> void:
	pass
