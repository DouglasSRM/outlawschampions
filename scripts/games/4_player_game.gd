extends GameScene

@onready var healthL: Label = $GUI/Control/HealthL
@onready var healthU: Label = $GUI/Control/HealthU
@onready var healthR: Label = $GUI/Control/HealthR

@onready var opponentL: ChampionCard = null
@onready var opponentU: ChampionCard = null
@onready var opponentR: ChampionCard = null

const opponentL_position = Vector3(1.8,0,0.9)
const opponentU_position = Vector3(0,0,1.7)
const opponentR_position = Vector3(-1.8,0,0.9)

func _on_loaded() -> void:
	self.round = randi_range(0,3)
	super()

func define_champion_positions():
	super()
	
	opponentL = Global.enemy_1
	opponentU = Global.enemy_2
	opponentR = Global.enemy_3
	
	cards.add_child(opponentL)
	cards.add_child(opponentU)
	cards.add_child(opponentR)
	
	opponentL.parent = self
	opponentU.parent = self
	opponentR.parent = self
	
	opponentL.default_position = opponentL_position
	opponentU.default_position = opponentU_position
	opponentR.default_position = opponentR_position
	
	opponentL.set_champion_state()
	opponentU.set_champion_state()
	opponentR.set_champion_state()


func _process(_delta: float) -> void:
	if champion:
		health.text = str(champion.health)+"/"+str(champion.max_health) + "\n" + str(champion.mana)+"/"+str(champion.max_mana)
	if opponentL:
		healthL.text = str(opponentL.health)+"/"+str(opponentL.max_health) + "\n" + str(opponentL.mana)+"/"+str(opponentL.max_mana)
	if opponentU:
		healthU.text = str(opponentU.health)+"/"+str(opponentU.max_health) + "\n" + str(opponentU.mana)+"/"+str(opponentU.max_mana)
	if opponentR:
		healthR.text = str(opponentR.health)+"/"+str(opponentR.max_health) + "\n" + str(opponentR.mana)+"/"+str(opponentR.max_mana)
