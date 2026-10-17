class_name PopUp
extends Sprite2D

@export var buttCerrar: Button
@export var nivel := 0

@export var randomMargin := Vector2(200, 50)

func _ready():
	buttCerrar.pressed.connect(cerrar)
	
	hide()
	

func mostrar():
	var r = RandomNumberGenerator.new()
	position += Vector2(r.randf_range(-randomMargin.x, +randomMargin.x), r.randf_range(-randomMargin.y, +randomMargin.y))
	
	show()
	

signal cerrado(refe: Popup)
func cerrar():
	hide()
	cerrado.emit(self)
	
