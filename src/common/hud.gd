extends Control
signal start
signal  retry

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func reduce_life(life):
	life = life - 1
	$LifeLabel.text = "x " + str(life)
	retry_game()

	
func _on_player_hit():
	var life = $LifeLabel.text.split(' ')[1]
	life = int(life)
	if life > 0:
		reduce_life(life)
	else:
		game_over()
		
func retry_game():
	retry.emit()
	
func game_over():
	start.emit()

func next_stage(num):
	$StageLabel.text = num
