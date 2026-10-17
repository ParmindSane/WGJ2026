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

@export_file("*.txt") var guion: String

func _ready():
	opcionesNodo.dijoNo.connect(dijoNo)
	popUpsNodos.cerrados.connect(func(): popUpsCerrados = true)
	resized.connect(scrollDown)
	
	var archivo = FileAccess.open(guion, FileAccess.READ)
	while !archivo.eof_reached():
		var linea = archivo.get_line()
		var columnas = linea.split(" ; ")
		
		if columnas.size() > 1:
			if columnas[0] == "?":
				opciones.push_back({"yes": columnas[1], "no": columnas[2]})
				
				mensajesDatos.push_back([])
				mensajesDatos[-1].push_back({"izquierda": true, "delay": 0, "texto": columnas[2]})
			else:
				mensajesDatos[-1].push_back({"izquierda": false, "delay": columnas[1], "texto": columnas[2]})
	archivo.close()
	
	recibirMensajes()
	

func recibirMensajes():
	for d in mensajesDatos[tanda]:
		await get_tree().create_timer(float(d.delay)).timeout
		
		var m: Mensaje = mensajeRefe.instantiate()
		m.setData(d.texto, d.izquierda)
		mensajesNodos.push_back(m)
		add_child(m)
	
	popUpsCerrados = false
	await get_tree().create_timer(1).timeout
	
	if tanda < opciones.size():
		opcionesNodo.setOpciones(opciones[tanda].yes, opciones[tanda].no, tanda)
	

func dijoNo(_tanda: int):
	print("Dijo que no y los popups están " + str(popUpsCerrados))
	if _tanda == tanda && popUpsCerrados:
		opcionesNodo.hide()
		
		tanda += 1
		recibirMensajes()
	

func scrollDown():
	await get_tree().create_timer(get_process_delta_time()).timeout
	scrollNodo.scroll_vertical = ceil(scrollNodo.get_v_scroll_bar().max_value)
	
