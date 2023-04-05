extends MeshInstance3D


func _on_totem_has_been_activated():
	$AnimationPlayer.play("platform")
