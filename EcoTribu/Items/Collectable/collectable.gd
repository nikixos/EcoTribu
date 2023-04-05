extends Area3D

@export_enum("AGUA","AIRE","SOLAR") var type : String
@onready var sprite_3d = $Sprite3D

func _ready():
	match type:
		"AGUA":
			sprite_3d.texture = load("res://Items/Collectable/waterMineral.png")
		"AIRE":
			sprite_3d.texture = load("res://Items/Collectable/AirCleaner.png")
		"SOLAR":
			sprite_3d.texture = load("res://Items/Collectable/sunEnergy.png")
func _on_body_entered(body):
	if body is Player:
		SignalsGlobal.emit_signal("collected",type)
		queue_free()
