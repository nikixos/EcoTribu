extends Control


func _on_timer_timeout():
	Global.collected = [0,0,0]
	Global.collectableTotal = [0,0,0]
	Global.totemsActivados = 0
	get_tree().change_scene_to_file("res://World/world.tscn")
