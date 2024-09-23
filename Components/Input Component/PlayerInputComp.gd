class_name PLAYER_INPUT extends INPUT

var runInput : bool
var Is_Attacking : bool
@export var AttackComp : Attack_Comp
@export var PowHandler : Uppgrade

func handleMoveInputs(_delta):
	moveInput = Input.get_axis("Move_left","Move_right")
	jumpInput = Input.is_action_just_pressed("Jump")
	DropDownInput = Input.is_action_just_pressed("Down")

func ActionInputs():
	
	DashInput = Input.is_action_just_pressed("Dash")
	if DashInput:
		PowHandler.Call_Action(Up_Handler.Actions.Dash)
	
	GrndPndInput = attackInput and DropDownInput
	if GrndPndInput:
		PowHandler.Call_Action(Up_Handler.Actions.GrndPnd)
	
	


#base function to later handle attack sequences and abilities
func HandleAttackInputs():
	
	attackInput = Input.is_action_just_pressed("Attack")
	if attackInput:
		AttackComp._Deal_DMG()
	
