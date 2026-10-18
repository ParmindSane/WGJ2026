class_name Perfiles
extends VBoxContainer

@export var chatActivo := 0
@export var chatsControl: Array[Mensajes]
@onready var chats: Array[Node2D]

@export var butts: Array[BaseButton]
var buttStyle := preload("res://chatApp/buttPerfil.tres")
var chatVisible := 0

var final = preload("res://endings/endings.tscn")

func _ready():
	for c in chatsControl:
		c.finDeChat.connect(finDeChat)
		chats.push_back(c.chatNodo)
	
	for b in butts:
		var i = butts.find(b)
		b.pressed.connect(switchChats.bind(i))
	
	switchChats(0)
	chatsControl[chatActivo].recibirMensajes()
	

func finDeChat():
	if chatActivo < chats.size():
		chatActivo += 1
		
		print(chatsControl[chatActivo])
	else:
		TheMaster.goToScene(final, TheMaster.finales.bueno)
	

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
	
