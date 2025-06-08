class_name BaseCard
extends Node3D

enum {
	IN_DECK,
	IN_HAND,
	IN_TABLE
}

var state = IN_HAND
var hand_position = 0

var entered = false
var hand_pos = Vector3(0,0,0)
var hover_pos = Vector3(0,0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func deck_click():
	get_parent().manage_deck_click(self)

func set_texture(texture: Texture2D) -> bool:
	$Sprite.texture = texture
	return true

func set_deck_position(pos: int) -> bool:
	var y = pos * 0.01
	position = Vector3(-2.8, y, -4.0)
	rotation = Vector3(1.570796, 0.0, 0.0)
	
	return true

func update_hand_position(pos: int, total: int) -> bool:	
	if pos != 0: # 0 mantem a posição atual
		hand_position = pos

	# calcula a posição inicial das cartas
	var initial_position = ((0.6 * (total - 1)) / 2)
	
	# diminui em 0.6 a posição x para cada carta
	var x: float = initial_position - (0.6 * (hand_position - 1))
	print(x)
	
	hand_pos = Vector3(x, 0.75, -7.0)
	
	var pos_x = (hand_pos[0] / 4) * 3
	var pos_y = hand_pos[1] + 0.5
	var pos_z = hand_pos[2] - 0.15
	hover_pos = Vector3(pos_x, pos_y, pos_z)
	move_to_position_in_hand(hand_pos)
	rotation = Vector3(-0.785398, -3.141593, 0.0)
	return true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_hand_state():
	state = BaseCard.IN_HAND

func move_to_position_in_hand(target_position: Vector3):
	get_parent().deck_lock()
	
	var duration = 0.5
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	set_hand_state()
	
	get_parent().deck_unlock()

func _on_body_mouse_entered() -> void:
	if state == BaseCard.IN_HAND:
		entered = true		
		move_to_position(hover_pos, 0.2)

func _on_body_mouse_exited() -> void:
	if state == BaseCard.IN_HAND and entered == true:
		entered = false
		move_to_position(Vector3(hand_pos), 0.2)

func move_to_position(target_position: Vector3, duration: float):
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
