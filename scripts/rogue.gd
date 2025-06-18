class_name Rogue
extends ChampionCard


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_health = 60
	health = max_health
	power = 5
	max_mana = 4
	mana = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
