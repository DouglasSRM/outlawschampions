extends Actor

@onready var player_positions: Node = $"../../PositionComponents/PlayerPositions"

func _ready():
	self.position_component = player_positions
	self.champion = Global.player_champion
