class_name Druid
extends ChampionCard

const special_rounds: int = 2
var special_rounds_left: int = -1
var old_hp: int

func _ready() -> void:
	super()
	max_health = 60
	health = max_health
	power = 5
	max_mana = 4
	mana = 0
	special_mana = 4

func on_start_round():
	super()
	update_special_status()

func update_special_status():
	if special_rounds_left < 0:
		return
	
	if special_rounds_left == 0:
		health = min(health, old_hp)
	
	special_rounds_left -= 1

func add_mana():
	if can_get_mana():
		super()

func can_get_mana() -> bool:
	return (special_rounds_left <= 0)

func special_attack():
	await self.playing_animation()
	mana -= special_mana
	
	special_rounds_left = special_rounds
	old_hp = health
	health = (health*2)
	
	super()
