extends Node

var player_champion: ChampionCard = null
var enemy_1: ChampionCard = null
var enemy_2: ChampionCard = null
var enemy_3: ChampionCard = null

const basic_attack_scene       = preload("res://scenes/basic_attack.tscn")
const opportunity_attack_scene = preload("res://scenes/opportunity_attack.tscn")
const parry_scene              = preload("res://scenes/parry.tscn")
const protector_shield_scene   = preload("res://scenes/protector_shield.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
