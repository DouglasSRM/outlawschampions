extends Node

var player_champion: ChampionCard = null
var enemy_1: ChampionCard = null
var enemy_2: ChampionCard = null
var enemy_3: ChampionCard = null

var all_champions: Array[ChampionCard]

const basic_attack_scene       = preload("res://scenes/action/basic_attack.tscn")
const opportunity_attack_scene = preload("res://scenes/action/opportunity_attack.tscn")
const powerful_attack_scene    = preload("res://scenes/action/powerful_attack.tscn")
const lilting_attack_scene     = preload("res://scenes/action/lilting_attack.tscn")

const parry_scene              = preload("res://scenes/support/parry.tscn")
const protector_shield_scene   = preload("res://scenes/support/protector_shield.tscn")

func get_alive_enemies(sender: ChampionCard) -> Array[ChampionCard]: 
	return all_champions.filter(func(c): return c != sender and c.health_status != ChampionCard.hStatus.DEAD)

func get_random_enemy(sender: ChampionCard) -> ChampionCard:
	var possible_enemies = get_alive_enemies(sender)
	return possible_enemies[randi_range(0, possible_enemies.size() - 1)]
