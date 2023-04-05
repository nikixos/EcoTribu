extends ColorRect
 
@export var dialogPath = ""
@export var textSpeed = 0.05
 
var dialog
 
var phraseNum = 0
var finished = false
 
var canRecieveInput = false
func _ready():
	print("Hello")
	get_tree().get_first_node_in_group("Player").canMove = false
	get_tree().get_first_node_in_group("Player").velocity = Vector3.ZERO
	
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()
	await get_tree().create_timer(.3).timeout
	canRecieveInput = true
 
func _process(_delta):
	
	$Indicator.visible = finished
	if canRecieveInput and Input.is_action_just_pressed("jump"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)
 
func getDialog() -> Array:
	var f = FileAccess.open(dialogPath, FileAccess.READ)
	assert(f.file_exists(dialogPath), "File path does not exist")
	
	var json = f.get_as_text()
	
	var output = JSON.parse_string(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
 
func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		get_tree().get_first_node_in_group("Player").canMove = true
		queue_free()
		return
	
	finished = false
	
	$Name.bbcode_text = dialog[phraseNum]["Name"]
	$Text.bbcode_text = dialog[phraseNum]["Text"]
	
	$Text.visible_characters = 0
	

#	var img = dialog[phraseNum]["Name"] + dialog[phraseNum]["Emotion"] + ".png"
#	var f = FileAccess.open(img,FileAccess.READ)
#	if f.file_exists(img):
#		$Portrait.texture = load(img)
#	else: $Portrait.texture = null
#
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		$Timer.start()
		$AudioLetter.pitch_scale = randf_range(.8,1.2)
		$AudioLetter.play()
		await $Timer.timeout
	
	finished = true
	phraseNum += 1
	return
