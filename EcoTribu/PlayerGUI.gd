extends CanvasLayer

@onready var itemsTotalGUI = [$HBoxContainer/AguaHBoxContainer/ItemsTotalLabel,$HBoxContainer/SolarHBoxContainer2/ItemsTotalLabel,$HBoxContainer/AireHBoxContainer3/ItemsTotalLabel]
@onready var itemsCollectedGUI = [$HBoxContainer/AguaHBoxContainer/ItemsHaveLabel,$HBoxContainer/SolarHBoxContainer2/ItemsHaveLabel,$HBoxContainer/AireHBoxContainer3/ItemsHaveLabel]
func fillerinoGUITotal():
	var i = 0
	for elemnode in itemsCollectedGUI:
		elemnode.text = "0"
	for elem in Global.collectableTotal:
		itemsTotalGUI[i].text = str(elem)
		i+=1

func refreshGUICollectables(type):
	var tween = get_tree().create_tween()
	tween.tween_property($HBoxContainer,"scale",Vector2(1.5,1.5),.3)
	tween.tween_property($HBoxContainer,"scale",Vector2(1,1),.1)
	match type:
		"AGUA":
			itemsCollectedGUI[0].text = str(Global.collected[0])
		"AIRE":
			itemsCollectedGUI[1].text = str(Global.collected[1])
		"SOLAR":
			itemsCollectedGUI[2].text = str(Global.collected[2])

