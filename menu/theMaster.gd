extends Node

@onready var sonido: AudioStreamPlayer = $AudioStreamPlayer

var menu := preload("res://menu/menu.tscn")
var final := 0

func _ready() -> void:
	connect_buttons(get_tree().root)
	get_tree().node_added.connect(_on_node_added)

func connect_buttons(parent: Node) -> void:
	for child in parent.get_children():
		if child is BaseButton:
			var c: BaseButton = child
			c.pressed.connect(_play_sound)
			
			if c.get_meta("buttSalir"):
				c.pressed.connect(goToScene.bind(menu, 0))
		
		if child.get_child_count() > 0:
			connect_buttons(child)
	
func _on_node_added(node: Node) -> void:
	if node is BaseButton:
		node.pressed.connect(_play_sound)
	
func _play_sound() -> void:
	sonido.play()
	

func goToScene(_escena: PackedScene, _final: int):
	final = _final
	
	if final == 0 && DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		get_tree().change_scene_to_packed(_escena)
	
