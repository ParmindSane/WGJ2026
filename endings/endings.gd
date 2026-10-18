class_name Endings
extends CanvasLayer

enum finales {
	ninguno,
	buenardo,
	bueno1,
	bueno2,
	malo1,
	malo2
}
@onready var final := finales.ninguno

@export var texturas: Dictionary[finales, Texture2D]
@export var rect: TextureRect
@export var salir: BaseButton

var chatTerminado: Mensajes

func _ready():
	hide()
	
	salir.pressed.connect(ocultar)
	

func mostrar(_final: finales, _mensajes: Mensajes):
	final = _final
	rect.texture = texturas[final]
	chatTerminado = _mensajes
	
	show()
	

func ocultar():
	if final == finales.malo1 || final == finales.malo2:
		get_tree().change_scene_to_file("res://menu/menu.tscn")
	else:
		print("Avisando que se cerró el final")
		chatTerminado.terminarChat()
	
	hide()
	
