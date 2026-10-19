class_name Perfiles
extends VBoxContainer

@export var chatActivo := 0
@export var chatsControl: Array[Mensajes]
@onready var chats: Array[Node2D]

@export var butts: Array[BaseButton]
var buttStyle := preload("res://chatApp/buttPerfil.tres")
var chatVisible := 0

@export var final: Endings

@export var salir: BaseButton

func _ready():
	salir.pressed.connect(func(): DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED))
	
	for c in chatsControl:
		c.mensajeRecibido.connect(notificar)
		c.finDeChat.connect(finDeChat)
		chats.push_back(c.chatNodo)
	
	for b in butts:
		var i = butts.find(b)
		b.pressed.connect(switchChats.bind(i))
	
	switchChats(0)
	await get_tree().create_timer(2).timeout
	
	chatsControl[chatActivo].recibirMensajes()
	

func notificar(_mensajes: Mensajes):
	if(chatActivo != chatVisible):
		var s = buttStyle.duplicate()
		s.bg_color = Color(0.95, 1.0, 0.0, 0.294)
		butts[chatActivo].add_theme_stylebox_override("normal", s)
	

func finDeChat():
	print("Chat activo de " + str(chatActivo) + " a " + str(chatActivo+1))
	chatActivo += 1
	if chatActivo < chats.size():
		await get_tree().create_timer(1.25).timeout
		chatsControl[chatActivo].recibirMensajes()
	else:
		print("Final buenardo")
		final.mostrar(Endings.finales.buenardo, chatsControl[chatActivo-1])
	

func switchChats(_i: int):
	chatVisible = _i
	for i in butts.size():
		if i == chatVisible:
			butts[i].add_theme_stylebox_override("normal", buttStyle)
			chats[i].show()
		else:
			var s = buttStyle.duplicate()
			s.bg_color = Color(0.0, 0.0, 0.0, 0.0)
			butts[i].add_theme_stylebox_override("normal", s)
			chats[i].hide()
	
