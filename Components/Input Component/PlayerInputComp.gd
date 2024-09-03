class_name PLAYER_INPUT extends INPUT

var runInput : bool
var Is_Attacking : bool



func handleMoveInputs(delta):
	moveInput = Input.get_axis("Move_left","Move_right")
	jumpInput = Input.is_action_just_pressed("Jump")
	DropDownInput = Input.is_action_just_pressed("Down")

#base function to later handle attack sequences and abilities
func HandleAttackInputs():
	
	attackInput = Input.is_action_just_pressed("Attack")
	
