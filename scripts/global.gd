extends Node

var sender = null
var champion2 = null
var champion3 = null
var champion4 = null

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
