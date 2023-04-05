extends Node
@onready var player_gui = $PlayerGUI
var collected = [0,0,0]
var collectableTotal = [0,0,0] #Agua, Aire, Solar
var totemsActivados = 0

func _ready():
	SignalsGlobal.connect("collected",on_collectable)


func on_collectable(type : String):
	$CollectedSound.play()
	match type:
		"AGUA":
			collected[0] += 1
		"AIRE":
			collected[1] += 1
		"SOLAR":
			collected[2] += 1
	player_gui.refreshGUICollectables(type)
