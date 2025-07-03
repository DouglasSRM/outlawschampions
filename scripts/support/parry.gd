class_name Parry
extends SupportCard

func _ready() -> void:
	super()
	description = 'Blocks attack and counter attacks with your base damage ('+str(Global.player_champion.power)+')'
