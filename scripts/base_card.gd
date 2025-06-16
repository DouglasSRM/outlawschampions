class_name BaseCard
extends Node3D

enum {
	NONE,
	CHAMPION,
	IN_DECK,
	IN_HAND,
	IN_TABLE
}

@onready
var parent = get_parent().get_parent()
 
var state = NONE
var hand_position = 0
var table_position = 0
var deck_position = 0

var entered = false
var hand_pos = Vector3(0,0,0)
var hover_pos = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#update_hand_position(0,1)

func hand_click():
	parent.manage_hand_click(self)

func deck_click():
	parent.manage_deck_click()

func set_texture(texture: Texture2D) -> bool:
	$Sprite.texture = texture
	return true

func set_deck_position(pos: int) -> bool:
	deck_position = pos
	var y = pos * 0.01
	position = Vector3(-0.5, y, 0.9)
	rotation = Vector3(deg_to_rad(-90), deg_to_rad(-90), 0.0)
	
	return true

func update_table_position(pos: int, total: int) -> bool:	
	hand_position = 0
	
	if pos != 0: # 0 mantem a posição atual
		table_position = pos
	
	var z: float = -0.85 # table
	var card_distance = 0.6
	# calcula a posição inicial das cartas
	var initial_position = ((card_distance * (total - 1)) / 2)
	
	# diminui em 0.6 a posição x para cada carta
	var x: float = initial_position - (card_distance * (table_position - 1))
	
	var table_pos = Vector3(x, 0, z)
	move_state(table_pos, IN_TABLE)
	return true

func update_hand_position(pos: int, total: int) -> bool:	
	deck_position = 0
	
	if pos != 0: # 0 mantem a posição atual
		hand_position = pos
	
	var z = -1.75 # hand
	
	var card_distance = 0.6
	# calcula a posição inicial das cartas
	var initial_position = ((card_distance * (total - 1)) / 2)
	
	# diminui em 0.6 a posição x para cada carta
	var x: float = initial_position - (card_distance * (hand_position - 1))
	
	hand_pos = Vector3(x, 0, z)
	
	update_hover_pos(hand_pos)
	move_state(hand_pos, IN_HAND)
	rotation = Vector3(deg_to_rad(-90), deg_to_rad(180), 0.0)
	
	return true

func update_hover_pos(pos: Vector3):
	var pos_x = (pos[0] / 4) * 3.07
	var pos_y = 0.7  
	var pos_z = pos[2] - (pos[2] / 4.23)
	hover_pos = Vector3(pos_x, pos_y, pos_z)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func move_state(target_position: Vector3, new_state):
	parent.lock()
	
	var duration = 0.5
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	state = new_state
	
	parent.unlock()

func _on_body_mouse_entered() -> void:
	if parent.move_locked:
		return
		
	if state == IN_HAND:
		entered = true		
		move_to_position(hover_pos, 0.2)

func _on_body_mouse_exited() -> void:
	if parent.move_locked:
		return
	
	if state == BaseCard.IN_HAND and entered == true:
		entered = false
		move_to_position(Vector3(hand_pos), 0.2)

func move_to_position(target_position: Vector3, duration: float):
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
