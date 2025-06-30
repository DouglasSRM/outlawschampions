class_name Actor extends Node

var position_component: PostionComponent
var champion: ChampionCard

var hand_count: int = 0
var table_count: int = 5
## How many support cards can the actor currently buy
var can_buy_support: int = 0
## How many action cards can the actor currently buy
var can_buy_action: int = 0
