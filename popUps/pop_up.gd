class_name PopUp
extends Sprite2D

@export var buttCerrar: Button

func _ready():
	pass
	

signal cerrado
func cerrar():
	hide()
	
	cerrado.emit()
	
