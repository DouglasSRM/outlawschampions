class_name OpportunityAttack
extends ActionCard

var damage = Global.sender.power * 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	description = 'Deals DOUBLE the base damage of your champion ('+str(damage)+') to a random enemy'


func play() -> bool:
	var enemy: ChampionCard
	match randi_range(1,3):
		1: enemy = Global.champion2
		2: enemy = Global.champion3
		_: enemy = Global.champion4
	
	enemy.decrease_health(damage)
	parent.show_enemy(enemy)
	
	return await super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
