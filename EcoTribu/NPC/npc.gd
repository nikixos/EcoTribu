extends StaticBody3D
@onready var talk_sprite_3d = $TalkSprite3D
@onready var messageScene = preload("res://NPC/msg_ui_dialogue.tscn")

@export var dialoguePath : String



var canTalk = false :
	set(value):
		canTalk = value
		talk_sprite_3d.visible = canTalk
func _on_area_3d_hablar_body_entered(body):
	if body is Player:
		canTalk = true


func _on_area_3d_hablar_body_exited(body):
	if body is Player:
		canTalk = false


func _input(event):
	if canTalk and event.is_action_pressed("jump"):
		canTalk = false
		talk()

func talk():
	var nDialogue = messageScene.instantiate()
	nDialogue.get_node("DialogBox").dialogPath = dialoguePath
	add_child(nDialogue)
	print("estoy hablando")
