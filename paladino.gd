extends Sprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_static_body_3d_mouse_entered() -> void:
	print(position[0])
	position[0] -= 0.01
	position[1] += 0.5
	position[2] -= 0.15


func _on_static_body_3d_mouse_exited() -> void:
	print(position[0])
	position[0] += 0.01
	position[1] -= 0.5
	position[2] += 0.15
