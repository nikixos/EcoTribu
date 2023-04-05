extends Node


func _ready():
	
	var collectableTotal = get_tree().get_nodes_in_group("Collectables")
	for elem in collectableTotal:
		match elem.type:
			"AGUA":
				Global.collectableTotal[0] += 1
			"AIRE":
				Global.collectableTotal[1] += 1
			"SOLAR":
				Global.collectableTotal[2] += 1
	Global.player_gui.fillerinoGUITotal()
	

var arrSoundsFondo = [
	preload("res://World/Assets/soundsRand/fog_wind01.WAV"),
	preload("res://World/Assets/soundsRand/fog_wind02.WAV"),
	preload("res://World/Assets/soundsRand/wind_howling_a.WAV"),
	preload("res://World/Assets/soundsRand/wind_howling_B.WAV"),
	preload("res://World/Assets/soundsRand/wind_howling_c.WAV"),
	preload("res://World/Assets/soundsRand/wind_sea_sands.WAV")
]
func _on_fondo_audio_finished():
	$FondoAudio.play()
	$FondoAudio/FondoAudio2.stream = arrSoundsFondo.pick_random()
	$FondoAudio/FondoAudio2.play()

var totemsLocal = 0
func _on_totem_has_been_activated():
	totemsLocal+=1
	if totemsLocal >= 2:
		var tween = get_tree().create_tween()
		tween.tween_property($PrototypeWorld/Door,"position",Vector3(-10,14,138),1)
		$PrototypeWorld/Door/DoorAudio.play()


func _on_finalof_l_evel_area_3d_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_file("res://World/end_game.tscn")
		pass
