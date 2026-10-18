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
	print("mostrar final " + str(_final))
	
	final = _final
	rect.texture = texturas[final]
	chatTerminado = _mensajes
	
	if final == finales.bueno1 || final == finales.bueno2 || finales.buenardo:
		GlobalSonido.cambiarMusiquita(GlobalSonido.musiquitasNombres.menu)
	else:
		GlobalSonido.cambiarMusiquita(GlobalSonido.musiquitasNombres.juego)
	
	show()
	

func ocultar():
	hide()
	print("ocultar ending " + str(final))
	if final == finales.bueno1:
		GlobalSonido.cambiarMusiquita(GlobalSonido.musiquitasNombres.juego)
		chatTerminado.terminarChat()
	elif final == finales.bueno2:
		mostrar(finales.buenardo, chatTerminado)
	else:
		GlobalSonido.cambiarMusiquita(GlobalSonido.musiquitasNombres.menu)
		get_tree().change_scene_to_file("res://menu/menu.tscn")
	
