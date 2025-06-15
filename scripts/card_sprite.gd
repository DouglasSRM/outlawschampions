extends Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_click():
	match get_parent().state:
		BaseCard.IN_DECK:
			get_parent().deck_click()
		BaseCard.IN_HAND:
			get_parent().hand_click()
