extends Actor

@onready var op_right_positions: Node = $"../../PositionComponents/OpRightPositions"

func _ready():
	self.position_component = op_right_positions
	self.champion = Global.enemy_3
