class_name Poison
extends Effect

var damage: int

func _ready() -> void:
	total_rounds = 5

func execute():
	super()
	self.champion.decrease_health(self.damage)

func apply(champion: ChampionCard):
	super(champion)
	self.damage = randi_range(1,4)
