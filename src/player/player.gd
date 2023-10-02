extends CharacterBody2D
signal hit
signal clear

const SPEED = 600.0
const JUMP_VELOCITY = -700.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		$AnimatedSprite2D.animation = "jump"
		velocity.y += gravity * delta
	else:
		$AnimatedSprite2D.animation = "walk"

	# Handle Jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0

	move_and_slide()
	

func _on_hit_box_body_entered(body):
	if body.name == "Trap" or body.name == "Enemy":
		death_player()
	elif body.name == "End":
		clear.emit()
	
func death_player():
	hide()
	hit.emit()
	

func start(pos):
	show()
	position = pos



