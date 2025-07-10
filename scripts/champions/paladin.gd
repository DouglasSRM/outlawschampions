class_name Paladin
extends ChampionCard

const special_rounds: int = 3
var special_rounds_left: int = -1
var special_lock: bool = false

func _ready() -> void:
	super()
	max_health = 65
	health = max_health
	power = 4
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
		special_lock = false
	
	special_rounds_left -= 1

func decrease_health(value):
	if special_lock:
		return
	super(value)

func add_mana():
	if can_get_mana():
		super()

func can_get_mana() -> bool:
	return (special_rounds_left <= 0)

func special_attack():
	await self.playing_animation()
	mana -= special_mana
	
	special_rounds_left = special_rounds
	special_lock = true
	
	super()
