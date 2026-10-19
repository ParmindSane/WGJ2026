class_name PopUps
extends Node2D

@export var opciones: Opciones
var tanda := -1

var popupsPorNivel = []
var popupsVisibles: Array[Node]
var mostrando := false

var R := RandomNumberGenerator.new()

func _ready():
	opciones.dijoNo.connect(dijoNo)
	
	for i in range(3):
		popupsPorNivel.push_back(get_children().filter(
			func(p: Node): 
				if p is PopUp:
					return p.nivel <= i
				else:
					return false)
			)
	

func dijoNo(_tanda: int):
	if _tanda != tanda:
		tanda = _tanda
		mostrar()
	

func mostrar():
	mostrando = true
	
	for n in popupsPorNivel[tanda]:
		n.mostrar()
		await get_tree().create_timer(R.randf_range(0.1, 0.5)).timeout
	

signal cerrados(_tanda: int)
func _process(_delta):
	if mostrando:
		popupsVisibles = popupsPorNivel[tanda].filter(func(p: PopUp): return p.visible)
		print("Popups visibles: " + str(popupsVisibles))
		
		if popupsVisibles.size() == 0:
			mostrando = false
			cerrados.emit()
	
