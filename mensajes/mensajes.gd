class_name Mensajes
extends VBoxContainer

var mensajeRefe := preload("res://mensajes/mensaje.tscn")
var mensajesNodos: Array[Mensaje]
var mensajesDatos := []

@export_file("*.txt") var guion: String

func _ready():
	var archivo = FileAccess.open(guion, FileAccess.READ)
	while !archivo.eof_reached():
		var linea = archivo.get_line()
		var columnas = linea.split(" ; ")
		
		if columnas.size() > 1:
			mensajesDatos.push_back({"derecha": columnas[0], "delay": columnas[1], "texto": columnas[2]})
	archivo.close()
	
	for d in mensajesDatos:
		await get_tree().create_timer(float(d.delay)).timeout
		nuevoMensaje(d)
	

func nuevoMensaje(datos: Dictionary):
	var m: Mensaje = mensajeRefe.instantiate()
	m.setData(datos.texto, datos.derecha)
	add_child(m)
	
