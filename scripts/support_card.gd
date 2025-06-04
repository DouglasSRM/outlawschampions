class_name SupportCard
extends BaseCard


func get_deck_count() -> int:
	return parent.support_deck_count;
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	state_machine.init(self,deck)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
