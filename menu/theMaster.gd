extends Node

@onready var sonido: AudioStreamPlayer = $AudioStreamPlayer

var menu := preload("res://menu/menu.tscn")

enum finales {
	bueno,
	malo1,
	malo2
}
var final := finales.bueno

func _ready() -> void:
	connect_buttons(get_tree().root)
	get_tree().node_added.connect(_on_node_added)

func connect_buttons(parent: Node) -> void:
	for child in parent.get_children():
		if child is BaseButton:
			var c: BaseButton = child
			c.pressed.connect(_play_sound)
		
		if child.get_child_count() > 0:
			connect_buttons(child)
	
func _on_node_added(node: Node) -> void:
	if node is BaseButton:
		node.pressed.connect(_play_sound)
	
func _play_sound() -> void:
	sonido.play()
	

func goToScene(_escena: PackedScene, _final: finales):
	final = _final
	get_tree().change_scene_to_packed(_escena)
	
