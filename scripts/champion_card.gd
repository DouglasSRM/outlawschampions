class_name ChampionCard
extends BaseCard

enum hStatus {
	FULL,
	HALF,
	DYING
}

var default_position = Vector3(0,0,0)
var health_status = hStatus.FULL
var max_health: int
var health: int
var power: int
var max_mana: int
var mana: int

func decrease_health(value):
	health = max(0, health - value)
	
	update_status()

func attack(champion: ChampionCard, damage := power):
	champion.decrease_health(damage)

func update_status():
	match health:
		0: health_status = hStatus.DYING

func set_default_position(pos: Vector3, dur):
	default_position = pos
	update_hover_pos(default_position)
	move_to_position(default_position, dur)

func select():
	Global.player_champion = self
	parent.change_scene()


func on_mouse_entered() -> void:
	super()
	
	if !parent:
		return
		
		
	if parent.move_locked:
		return
		
	if state == CHAMPION:
		entered = true		
		move_to_position(hover_pos, 0.2)

func on_mouse_exited() -> void:
	super()
	
	if !parent:
		return
		
	if parent.move_locked:
		return
	
	if state == CHAMPION and entered == true:
		entered = false
		move_to_position(Vector3(default_position), 0.2)

func _ready() -> void:
	state = CHAMPION


func _process(delta: float) -> void:
	pass
