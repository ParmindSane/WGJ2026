class_name PopUp
extends Sprite2D

@export var buttCerrar: Button
@export var nivel := 0

@onready var R = RandomNumberGenerator.new()
@onready var selfSize := get_rect().size
var spawnArea: Vector2

func _ready():
	buttCerrar.pressed.connect(cerrar)
	
	var windowSize = get_viewport_rect().size
	spawnArea = windowSize - selfSize
	
	hide()
	

func mostrar():
	position = Vector2(R.randf_range(selfSize.x, spawnArea.x), R.randf_range(selfSize.y, spawnArea.y))
	
	show()
	

signal cerrado(refe: Popup)
func cerrar():
	hide()
	cerrado.emit(self)
	
