class_name Endings
extends Node2D

@onready var final = TheMaster.final
@export var finales: Dictionary[TheMaster.finales, Texture2D]
@export var rect: TextureRect
@export var salir: BaseButton

func _ready():
	rect.texture = finales[TheMaster.final]
	
	salir.hide()
	await get_tree().create_timer(float(2)).timeout
	salir.show()
	
