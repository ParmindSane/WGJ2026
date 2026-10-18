class_name Menu
extends Node2D

@export var buttPlay: BaseButton
var juegoEscena := preload("res://chatApp/chat.tscn")

func _ready():
	buttPlay.pressed.connect(play)
	GlobalSonido.cambiarMusiquita(GlobalSonido.musiquitasNombres.menu)

func play():
	GlobalSonido.cambiarMusiquita(GlobalSonido.musiquitasNombres.juego)
	get_tree().change_scene_to_packed(juegoEscena)
	
