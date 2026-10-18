extends Node

@onready var sonido: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	# Conectar los botones que ya están en el árbol de la escena al iniciar
	connect_buttons(get_tree().root)

	# Escuchar cuando se añadan nuevos nodos en tiempo de ejecución
	get_tree().node_added.connect(_on_node_added)

func _on_node_added(node: Node) -> void:
	if node is BaseButton:
		node.pressed.connect(_play_sound)

func connect_buttons(parent: Node) -> void:
	for child in parent.get_children():
		if child is BaseButton:
			child.pressed.connect(_play_sound)
		if child.get_child_count() > 0:
			connect_buttons(child)

func _play_sound() -> void:
	sonido.play()
	
