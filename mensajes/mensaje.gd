class_name Mensaje
extends PanelContainer

@export var derecha := true
@export var label: Label

func setData(_texto: String, _derecha: bool):
	label.text = _texto
	
	derecha = _derecha
	if derecha:
		size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		
		var estilo = get_theme_stylebox("panel").duplicate()
		estilo.bg_color = Color(0.361, 0.863, 0.278)
		estilo.shadow_color = Color(0.267, 0.729, 0.188)
		add_theme_stylebox_override("panel", estilo)
	
