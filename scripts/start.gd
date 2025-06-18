extends Node3D

var move_locked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for card in $"3D".get_children():
		if card is ChampionCard:
			card.hand_pos = card.position
			card.update_hover_pos()
			card.state = BaseCard.SELECT


func change_scene():
	$"3D".remove_child(Global.sender)
	Global.sender.state = BaseCard.CHAMPION
	
	var i = 0
	for card in $"3D".get_children():
		if card is ChampionCard and card != Global.sender:
			card.state = BaseCard.CHAMPION
			match i:
				0: Global.champion2 = card
				1: Global.champion3 = card
				2: Global.champion4 = card
			i = i+1
			$"3D".remove_child(card)
	
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func lock():
	move_locked = true
	
func unlock():
	move_locked = false
