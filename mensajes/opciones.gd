class_name Opciones
extends VBoxContainer

@export var buttYes: Button
@export var buttNo: Button
var tanda: int

@export var sonidos: AudioStreamPlayer

@export var badEnding: Endings.finales
@export var goodEnding: Endings.finales

func _ready():
	buttYes.pressed.connect(decirYes)
	buttNo.pressed.connect(decirNo)
	
	hide()
	

func setOpciones(_yes: String, _no: String, _tanda: int):
	buttYes.text = _yes
	buttNo.text = _no
	tanda = _tanda
	
	sonidos.play()
	
	show()
	

signal dijoYes()
func decirYes():
	dijoYes.emit()
	

signal dijoNo(tanda: String)
func decirNo():
	dijoNo.emit(tanda)
	

func puedeDecirNo(_puede: bool):
	buttNo.disabled = !_puede
	
