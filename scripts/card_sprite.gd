extends Sprite3D

var tamanho_fixo: Vector2 = Vector2(900, 1350)

func _ready():
	update_sprite_scale()

func update_sprite_scale():
	if texture:
		var tamanho_textura = texture.get_size()
		print(tamanho_textura)
		print(scale)
		if tamanho_textura.x != 0 and tamanho_textura.y != 0:
			scale.x = tamanho_fixo.x / tamanho_textura.x
			scale.y = tamanho_fixo.y / tamanho_textura.y
			$Body.scale.x = tamanho_textura.x / tamanho_fixo.x
			$Body.scale.y = tamanho_textura.y / tamanho_fixo.y
		print(scale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_click():
	print('a')
	match get_parent().state:
		BaseCard.SELECT:
			get_parent().select()
		BaseCard.IN_DECK:
			get_parent().deck_click()
		BaseCard.IN_HAND:
			get_parent().hand_click()
