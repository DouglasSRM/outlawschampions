class_name SupportCard
extends BaseCard

@onready var deck: CardState = $StateMachine/Deck


func _ready() -> void:
	state_machine.init(self,deck)


func play() -> bool:
	await super()
	parent.handle_equip(self)
	return true


func _process(delta: float) -> void:
	pass
