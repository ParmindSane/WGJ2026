class_name Mensajes
extends VBoxContainer

var mensajeRefe := preload("res://mensajes/mensaje.tscn")
var mensajesNodos: Array[Mensaje]
var mensajesDatos := [[]]
var opciones: Array[Dictionary]
var tanda := 0
var popUpsCerrados := true

@export var opcionesNodo: Opciones
@export var popUpsNodos: PopUps

@export var scrollNodo: ScrollContainer
@export var chatNodo: Node2D

@export_file("*.txt") var guion: String
var R := RandomNumberGenerator.new()

signal finDeChat
@export var finalesNodo: Endings

func _ready():
	opcionesNodo.dijoYes.connect(dijoYes)
	opcionesNodo.dijoNo.connect(dijoNo)
	popUpsNodos.cerrados.connect(desbloquearNo)
	resized.connect(scrollDown)
	
	var archivo = FileAccess.open(guion, FileAccess.READ)
	while !archivo.eof_reached():
		var linea = archivo.get_line()
		var columnas = linea.split(" ; ")
		
		if columnas.size() > 1:
			if columnas[0] == "?":
				print(columnas)
				opciones.push_back({"yes": columnas[1], "no": columnas[2]})
				
				mensajesDatos.push_back([])
				mensajesDatos[-1].push_back({"izquierda": true, "texto": columnas[2]})
			#elif columnas[0] == "p":
				#pass
			elif columnas[0] == "e":
				mensajesDatos[-1].push_back({"izquierda": true, "texto": columnas[1]})
			else:
				mensajesDatos[-1].push_back({"izquierda": false, "texto": columnas[1]})
	archivo.close()
	

var mensajeDelay := Vector2(2,3)
func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		mensajeDelay = Vector2(0.05,0.05)
	

func recibirMensajes():
	mensajeDelay = Vector2(2,3)
	for d in mensajesDatos[tanda]:
		var m: Mensaje = mensajeRefe.instantiate()
		m.setData(d.texto, d.izquierda)
		mensajesNodos.push_back(m)
		add_child(m)
		
		await get_tree().create_timer(R.randf_range(mensajeDelay.x, mensajeDelay.y)).timeout
	
	popUpsCerrados = false
	await get_tree().create_timer(1).timeout
	
	if tanda < opciones.size():
		opcionesNodo.setOpciones(opciones[tanda].yes, opciones[tanda].no, tanda)
	else:
		print("FIN DE CHAT")
		finalesNodo.mostrar(opcionesNodo.goodEnding, self)
	

func dijoYes():
	finalesNodo.mostrar(opcionesNodo.badEnding, self)
	
func terminarChat():
	print("Activar siguiente chat")
	finDeChat.emit()
	

func dijoNo(_tanda: int):
	print("Dijo que no y los popups están " + str(popUpsCerrados))
	if !popUpsCerrados:
		opcionesNodo.puedeDecirNo(false)
	else:
		opcionesNodo.hide()
		
		tanda += 1
		recibirMensajes()
	

func desbloquearNo():
	popUpsCerrados = true
	opcionesNodo.puedeDecirNo(true)
	

func scrollDown():
	await get_tree().create_timer(get_process_delta_time()).timeout
	scrollNodo.scroll_vertical = ceil(scrollNodo.get_v_scroll_bar().max_value)
	
