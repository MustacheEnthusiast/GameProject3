class_name INPUT extends Node


var moveInput : float	## Left and Right movement float. 
var jumpInput : bool	## True for jump, false otherwise. 

#/
## Return the Move Input float. 
func getMoveInput() -> float:
	return moveInput

#/
## Return the Jump Input bool. 
func getJumpInput() -> bool:
	return jumpInput

#/
## Base function to handle inputs. 
func handleMoveInputs(delta): 
	pass
