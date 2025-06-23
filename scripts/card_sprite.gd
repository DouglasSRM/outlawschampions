extends Sprite3D

var default_size: Vector2 = Vector2(900, 1350)

@onready var body: StaticBody3D = $Body


func _ready():
	update_sprite_scale()


func update_sprite_scale():
	if texture:
		var texture_size = texture.get_size()
		if texture_size.x != 0 and texture_size.y != 0:
			scale.x = default_size.x / texture_size.x
			scale.y = default_size.y / texture_size.y
			body.scale.x = texture_size.x / default_size.x
			body.scale.y = texture_size.y / default_size.y
