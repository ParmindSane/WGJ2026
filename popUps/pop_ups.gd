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
		for b in popupsPorNivel[-1]:
			b.cerrado.connect(cerrar)
	

func dijoNo(_tanda: int):
	if _tanda != tanda:
		tanda = _tanda
		mostrar()
	

func mostrar():
	mostrando = true
	
	for n in popupsPorNivel[tanda]:
		n.mostrar()
		await get_tree().create_timer(R.randf_range(0.1, 0.5)).timeout
	popupsVisibles = popupsPorNivel[tanda]
	

signal cerrados(_tanda: int)
func cerrar(_popap: PopUp):
	var i = popupsVisibles.find(_popap)
	popupsVisibles.remove_at(i)
	
	print("popups visibles: " + str(popupsVisibles.size()))
	if popupsVisibles.size() == 0:
		mostrando = false
		cerrados.emit()
	
