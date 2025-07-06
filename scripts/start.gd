extends Node3D

var move_locked: bool = false

@onready var caption: Label = $GUI/Control/Caption
@onready var cards: Node = $"3D/Cards"
@onready var btn_two_players: Button = $GUI/Control/Two_Players
@onready var btn_four_players: Button = $GUI/Control/Four_players

enum eGamemode {
	twoPlayers,
	fourPlayers
}

var gamemode: int

func _ready() -> void:
	caption.text = "Choose the game mode"
	
	for card in cards.get_children():
		card.visible = false
		card.parent = self


func manage_hover(card: BaseCard) -> bool:
	return true


func change_scene() -> void:
	cards.remove_child(Global.player_champion)
	Global.player_champion.state = BaseCard.CHAMPION

	match gamemode:
		eGamemode.twoPlayers: load_2_players()
		eGamemode.fourPlayers: load_4_players()


func load_2_players():
	var enemy_index = 0
	var rand = randi_range(0,2)
	for card in cards.get_children():
		if card != Global.player_champion:
			card.state = BaseCard.CHAMPION
			if enemy_index == rand:
				Global.enemy_1 = card
			enemy_index += 1
			cards.remove_child(card)
	Global.all_champions = [Global.player_champion, Global.enemy_1]
	get_tree().change_scene_to_file("res://scenes/games/2_player_game.tscn")


func load_4_players():
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
	Global.all_champions = [Global.player_champion, Global.enemy_1, Global.enemy_2, Global.enemy_3]
	get_tree().change_scene_to_file("res://scenes/games/4_player_game.tscn")


func lock():
	move_locked = true
	
func unlock():
	move_locked = false

func showChampions():
	btn_two_players.visible = false
	btn_four_players.visible = false
	for card in cards.get_children():
		card.visible = true
	caption.text = "Choose your champion!"


func _on_two_players_button_down() -> void:
	gamemode = eGamemode.twoPlayers
	showChampions()


func _on_four_players_button_down() -> void:
	gamemode = eGamemode.fourPlayers
	showChampions()
