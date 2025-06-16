class_name ChampionCard
extends BaseCard

enum eStatus {
	FULL,
	HALF,
	DYING
}

var health_status = eStatus.FULL
var max_health = 50
var health = 50
var power = 0

func decrease_health(value):
	health = max(0, health - value)
	
	update_status()

func update_status():
	match health:
		0: health_status = eStatus.DYING


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = CHAMPION
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
