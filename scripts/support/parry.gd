class_name Parry
extends SupportCard


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	description = 'Blocks attack and counter attacks with your base damage ('+str(Global.player_champion.power)+')'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
