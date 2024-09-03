class_name INPUT extends Node

var attackInput 
var moveInput : float	## Left and Right movement float. 
var jumpInput : bool	## True for jump, false otherwise. 
var DropDownInput

#/
## Return the Move Input float. 
func getMoveInput() -> float:
	return moveInput

#/
## Return the Jump Input bool. 
func getJumpInput() -> bool:
	return jumpInput

func getAttackInput():
	return attackInput

func getDropDownInput():
	return DropDownInput
#/
## Base function to handle inputs. 
func handleMoveInputs(delta): 
	pass


func HandleAttackInputs():
	pass
