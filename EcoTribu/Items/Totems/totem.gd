extends StaticBody3D

@export_enum("AGUA","AIRE","SOLAR") var type : String
signal hasBeenActivated

func _ready():
	$Label3D.text = "Totem "+type
	SignalsGlobal.collected.connect(on_collected)
	await(owner.ready)
	match type:
		"AGUA":
			$totalItemsNumber.text = str(Global.collectableTotal[0])
		"AIRE":
			$totalItemsNumber.text = str(Global.collectableTotal[1])
		"SOLAR":
			$totalItemsNumber.text = str(Global.collectableTotal[2])
	

var doOnce = false
func _on_area_3d_body_entered(body):
	if body is Player and !doOnce:
		var shouldActivate := false
		match type:
			"AGUA":
				if Global.collected[0] >= Global.collectableTotal[0]:
					shouldActivate = true
			"AIRE":
				if Global.collected[1] >= Global.collectableTotal[1]:
					shouldActivate = true
			"SOLAR":
				if Global.collected[2] >= Global.collectableTotal[2]:
					shouldActivate = true
		
		if shouldActivate:
			Global.totemsActivados+=1
			$Label3D.modulate = Color.BLUE
			doOnce = true
			emit_signal("hasBeenActivated")
			var tween = get_tree().create_tween()
			tween.tween_property($TotemModel,"scale",Vector3(.3,.3,.3),.3)
			tween.tween_property($TotemModel,"scale",Vector3(.1,.1,.1),.1)
			$DoneAudio.play()
		else:
			var tween = get_tree().create_tween()
			$CancelledAudio.play()
			tween.tween_property($TotemModel,"scale",Vector3(.05,.05,.05 ),.3)
			tween.tween_property($TotemModel,"scale",Vector3(.1,.1,.1),.1)

func on_collected(collectType):
	match type:
		"AGUA":
			$haveItemsNumber.text = str(Global.collected[0])
		"AIRE":
			$haveItemsNumber.text = str(Global.collected[1])
		"SOLAR":
			$haveItemsNumber.text = str(Global.collected[2])



