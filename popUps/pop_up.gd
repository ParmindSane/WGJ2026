class_name PopUp
extends PanelContainer

@export var nivel := 0

@export var botones: Control
@onready var butts := botones.get_children()
var buttActivo: BaseButton

@export var tiempo: Label
@export var tiempoMargen: Vector2
@onready var timer: Timer = tiempo.get_child(0)

@onready var R = RandomNumberGenerator.new()
@onready var selfSize := get_rect().size
var spawnArea: Vector2

func _ready():
	var windowSize = get_viewport_rect().size
	spawnArea = windowSize - selfSize
	
	for b in butts:
		b.pressed.connect(cerrar)
		b.hide()
	
	butts.shuffle()
	buttActivo = butts[0]
	buttActivo.show()
	
	tiempo.hide()
	
	hide()
	

func _process(_delta):
	if nivel == 2:
		if !timer.is_stopped():
			tiempo.text = str(ceil(timer.time_left))
	

func mostrar():
	position = Vector2(R.randf_range(selfSize.x, spawnArea.x), R.randf_range(selfSize.y, spawnArea.y))
	show()
	
	if nivel == 2:
		buttActivo.disabled = true
		tiempo.reparent(buttActivo, false)
		tiempo.show()
		timer.start(R.randf_range(tiempoMargen.x, tiempoMargen.y))
		
		await timer.timeout
		buttActivo.disabled = false
		tiempo.hide()
	

signal cerrado(refe: Popup)
func cerrar():
	var i = butts.find(buttActivo) + 1
	
	if nivel == 1 && i < R.randi_range(3, butts.size()):
		buttActivo.hide()
		buttActivo = butts[i]
		buttActivo.show()
	else:
		hide()
		cerrado.emit(self)
	
