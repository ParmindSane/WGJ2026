extends TextureButton

func _ready():
	pressed.connect(pulsado)

func pulsado():
	get_tree().change_scene_to_file("res://menu/menu.tscn")
	
