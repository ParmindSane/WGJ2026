extends Node

@export var butts: AudioStreamPlayer

@export var musiquita: AudioStreamPlayer
enum musiquitasNombres {
	juego,
	menu
}
@export var musiquitas: Dictionary[musiquitasNombres, AudioStream]

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
	butts.play()
	

func cambiarMusiquita(_mood: musiquitasNombres):
	if musiquitas[_mood] != musiquita.stream:
		musiquita.stream = musiquitas[_mood]
		musiquita.play()
	
