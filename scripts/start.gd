extends Node3D

var move_locked: bool = false

@onready var cards: Node = $"3D/Cards"


func _ready() -> void:
	for card in cards.get_children():
		card.parent = self


func manage_hover(card: BaseCard) -> bool:
	return true


func change_scene() -> void:
	cards.remove_child(Global.player_champion)
	Global.player_champion.state = BaseCard.CHAMPION
	
	var enemy_index = 0
	for card in cards.get_children():
		if card != Global.player_champion:
			card.state = BaseCard.CHAMPION
			match enemy_index:
				0: Global.enemy_1 = card
				1: Global.enemy_2 = card
				2: Global.enemy_3 = card
			enemy_index += 1
			cards.remove_child(card)
			
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func lock():
	move_locked = true
	
func unlock():
	move_locked = false
