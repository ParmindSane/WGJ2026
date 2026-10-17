class_name Opciones
extends VBoxContainer

@export var buttYes: Button
@export var buttNo: Button
var tanda: int

@export var badEnding: PackedScene

func _ready():
	buttYes.pressed.connect(goBadEnding)
	buttNo.pressed.connect(decirNo)
	

func setOpciones(_yes: String, _no: String, _tanda: int):
	buttYes.text = _yes
	buttNo.text = _no
	tanda = _tanda
	
	show()
	

func goBadEnding():
	get_tree().change_scene_to_packed(badEnding)
	

signal noEsNo(id: String)
func decirNo():
	noEsNo.emit(tanda)
	hide()
	
