class_name Rogue
extends ChampionCard

const poison_turns: int = 3
var poison_turns_left: int

func _ready() -> void:
	super()
	max_health = 60
	health = max_health
	power = 5
	max_mana = 4
	mana = 0
	special_mana = 4

func apply_passive_attacks(champion: ChampionCard) -> void:
	if poison_turns_left > 0:
		apply_poison(champion)

func set_poison():
	poison_turns_left = poison_turns

func apply_poison(champion: ChampionCard):
	var poison = Poison.new()
	self.add_child(poison)
	champion.apply_effect(poison)
	poison_turns_left -= 1

func special_attack():
	await self.playing_animation()
	mana -= special_mana
	
	set_poison()
	var enemy = Global.get_random_enemy(self)
	attack(enemy, power)
	parent.pop_card(enemy)
	
	super()
