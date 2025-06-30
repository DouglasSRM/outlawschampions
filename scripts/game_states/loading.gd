extends GameState

@onready var buying_support: GameState = $"../BuyingSupport"

func enter() -> void:
	# waits for player_champion to be defined
	while !(Global.player_champion is ChampionCard):
		await get_tree().create_timer(0.1).timeout
	
	parent.define_champion_positions()
	parent.set_camera_position(parent.camera_pos.START)
	
	parent.create_action_cards()
	parent.create_support_cards()
	parent.set_starter_hands()
	parent.define_current_actor()
	parent.emit_signal('loaded')

func start_round() -> GameState:
	return buying_support
