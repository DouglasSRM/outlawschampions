class_name ActionCard
extends BaseCard

@onready var deck: CardState = $StateMachine/Deck

func get_deck_count() -> int:
	return parent.action_deck_count;


func _ready() -> void:
	super()
	state_machine.init(self,deck)


func play() -> bool:
	await get_tree().create_timer(0.7).timeout
	parent.handle_discard(self)
	parent.next_round()
	return true

func _process(delta: float) -> void:
	pass
