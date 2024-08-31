class_name PLAYER_INPUT extends INPUT

var runInput : bool

func handleMoveInputs(delta):
	moveInput = Input.get_axis("Move_left","Move_right")
	jumpInput = Input.is_action_just_pressed("Jump")
