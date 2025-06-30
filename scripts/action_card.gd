class_name ActionCard
extends BaseCard

@onready var champion: ChampionCard = null
@onready var deck: CardState = $StateMachine/Deck

func get_deck_count() -> int:
	return parent.action_deck_count;


func _ready() -> void:
	super()
	state_machine.init(self,deck)
	champion = Global.player_champion


func get_random_enemy() -> ChampionCard:
	var all_champions = [Global.player_champion, Global.enemy_1, Global.enemy_2, Global.enemy_3]
	var possible_enemies = all_champions.filter(func(c): return c != actor.champion)
	
	return possible_enemies[randi_range(0, possible_enemies.size() - 1)]


func playing_animation():
	rotation = Vector3(deg_to_rad(-90), deg_to_rad(180), 0.0)
	set_actor()
	await self.move_to_position(Vector3(0,2,0), 0.5)
	await get_tree().create_timer(0.5).timeout
	
	var pos = self.actor.champion.position
	pos = Vector3(pos.x, 0.1, pos.z)
	
	await self.move_to_position(pos, 0.5)


func play() -> bool:
	await get_tree().create_timer(0.7).timeout
	parent.handle_discard(self)
	parent.next_round()
	return true

func _process(delta: float) -> void:
	pass
