class_name Mensaje
extends PanelContainer

@export var derecha := true

@export_group("Referencias internas")
@export var label: Label

func setData(_texto: String, _derecha: bool):
	label.text = _texto
	
	derecha = _derecha
	if derecha:
		size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		
	
