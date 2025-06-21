class_name ActionCard
extends BaseCard

@onready var champion: ChampionCard = null

func set_deck_position(pos: int) -> bool:
	deck_position = pos
	var y = pos * 0.005
	position = Vector3(-0.5, y, 0.9)
	rotation = Vector3(deg_to_rad(90), deg_to_rad(-90), 0.0)
	return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	champion = Global.player_champion


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
