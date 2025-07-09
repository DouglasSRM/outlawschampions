class_name Mage
extends ChampionCard

func _ready() -> void:
	super()
	max_health = 50
	health = max_health
	power = 8
	max_mana = 4
	mana = 0
	special_mana = 4

func special_attack():
	await self.playing_animation()
	mana -= special_mana
	for enemy in Global.get_alive_enemies(self):
		attack(enemy, 15)
		parent.pop_card(enemy)
	await get_tree().create_timer(0.7).timeout
	parent.next_round()
