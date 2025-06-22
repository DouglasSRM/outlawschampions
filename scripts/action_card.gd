class_name ActionCard
extends BaseCard

@onready var champion: ChampionCard = null


func get_deck_count() -> int:
	return parent.action_deck_count;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	state_machine.init(self,deck)
	champion = Global.player_champion


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
