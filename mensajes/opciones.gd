class_name Opciones
extends VBoxContainer

@export var buttYes: Button
@export var buttNo: Button
var tanda: int

@export var sonidos: AudioStreamPlayer

@export var badEnding: TheMaster.finales
var finales := preload("res://endings/endings.tscn")

func _ready():
	buttYes.pressed.connect(goBadEnding)
	buttNo.pressed.connect(decirNo)
	
	hide()
	

func setOpciones(_yes: String, _no: String, _tanda: int):
	buttYes.text = _yes
	buttNo.text = _no
	tanda = _tanda
	
	sonidos.play()
	
	show()
	

func goBadEnding():
	TheMaster.goToScene(finales, badEnding)
	

signal dijoNo(id: String)
func decirNo():
	dijoNo.emit(tanda)
	

func puedeDecirNo(_puede: bool):
	buttNo.disabled = !_puede
	
