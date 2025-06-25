class_name ActionCard
extends BaseCard

@onready var champion: ChampionCard = null
@onready var deck: CardState = $StateMachine/Deck

func get_deck_count() -> int:
	return parent.action_deck_count;


func _ready() -> void:
	state_machine.init(self,deck)
	champion = Global.player_champion


func play() -> bool:
	await super()
	parent.handle_discard(self)
	return true

func _process(delta: float) -> void:
	pass
