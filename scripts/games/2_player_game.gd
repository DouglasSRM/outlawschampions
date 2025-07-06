extends GameScene

@onready var healthU: Label = $GUI/Control/HealthU

@onready var opponentU: ChampionCard = null

const opponentU_position = Vector3(0,0,1.7)

func define_champion_positions():
	super()
	
	opponentU = Global.enemy_1
	cards.add_child(opponentU)
	
	opponentU.parent = self
	opponentU.default_position = opponentU_position
	opponentU.set_champion_state()


func _process(_delta: float) -> void:
	if champion:
		health.text = str(champion.health)+"/"+str(champion.max_health) + "\n" + str(champion.mana)+"/"+str(champion.max_mana)
	if opponentU:
		healthU.text = str(opponentU.health)+"/"+str(opponentU.max_health) + "\n" + str(opponentU.mana)+"/"+str(opponentU.max_mana)
