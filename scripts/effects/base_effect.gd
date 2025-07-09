class_name Effect
extends Node

var champion: ChampionCard

var total_rounds: int
var rounds_left: int

func execute():
	rounds_left -= 1

func apply(champion: ChampionCard):
	self.champion = champion
	rounds_left = total_rounds
