extends Node

const FINAL_STAGE_NUM = 2

var stage = preload("res://src/stage/stage_1_.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(stage)
	print(stage.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func new_game():
	$Player.start($StartPosition.position)
	$HUDLayer/HUD/LifeLabel.text = "x 5"	
	$HUDLayer/HUD.next_stage("1")
	stage.queue_free()
	var path = 'res://src/stage/stage_1_.tscn'
	stage = load(path).instantiate()
	$Player.start($StartPosition.position)
	add_child(stage)
	
	
func retry_game():
	$Player.start($StartPosition.position)


func clear_stage():
	var num = int(stage.name.split('_')[1])
	if num == FINAL_STAGE_NUM:
		clear_game()
		return
	num += 1
	$HUDLayer/HUD.next_stage(str(num))
	stage.queue_free()
	var path = 'res://src/stage/stage_' + str(num) + '_.tscn'
	stage = load(path).instantiate()
	$Player.start($StartPosition.position)
	add_child(stage)
	
func clear_game():
	print("clear")
