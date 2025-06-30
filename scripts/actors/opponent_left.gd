extends Actor

@onready var op_left_positions: Node = $"../../PositionComponents/OpLeftPositions"

func _ready():
	self.position_component = op_left_positions
	self.champion = Global.enemy_1
