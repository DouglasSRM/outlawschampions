extends Actor

@onready var op_up_positions: Node = $"../../PositionComponents/OpUpPositions"

func _ready():
	self.position_component = op_up_positions
	self.champion = Global.enemy_2
