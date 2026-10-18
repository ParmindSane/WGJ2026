class_name Mensaje
extends PanelContainer

@export var derecha := true
@export var label: Label

var estilo := preload("res://mensajes/mensajeEnviado.tres")

func setData(_texto: String, _derecha: bool):
	label.text = _texto
	
	derecha = _derecha
	if derecha:
		size_flags_horizontal = Control.SIZE_SHRINK_END
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		add_theme_stylebox_override("panel", estilo)
	
