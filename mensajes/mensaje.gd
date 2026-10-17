class_name Mensaje
extends PanelContainer

@export var derecha := true

@export_group("Referencias internas")
@export var label: Label

func setData(_texto: String, _derecha: String):
	label.text = _texto
	
	if _derecha:
		derecha = false
		
		size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		
	
