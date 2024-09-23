class_name VELOCITY extends Node2D

@export var SPEED : float = 500
@export var JUMP_FORCE : float = -700
@export var FastGrav : float

@export_group("Nodes")
@export var CharBody : CharacterBody2D
@export var InputNode : INPUT
@export var AnimCtrl : Anim_Control
var CurrentSpeed : float = SPEED
var HoldingJump : bool = false

var Active_State: Move_state = Move_state.Grounded
var Active_SubState : Grounded_Substate = Grounded_Substate.Idle
var Overrides : Overrieds_States = Overrieds_States.none

var can_move : bool = true

enum Move_state{Grounded,Falling,Ascending}
enum Grounded_Substate{Idle, Running}
enum Overrieds_States{
	none = 0,
	Dash = 1 << 0,
	stunned = 1 << 1
	}

signal Ascending
signal Falling
signal Grounded

signal Idle
signal Running
#signal Dash


#var test : Signal

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var grav_mod_min : float = 1
@export var grav_mod_max : float = 2

var grav_mod : float = 1

func _ready() -> void:
	
	pass


func handleVelocity(delta) -> void:
	

	
#region JumpCode
	
	if not CharBody.is_on_floor():
		CharBody.velocity.y += gravity * delta * grav_mod
	else:
		
		Set_Move_State(Move_state.Grounded)
		
	
	if Input.is_action_pressed("Down") and CharBody.is_on_floor():
		DropDown()
	
	if InputNode.getJumpInput() and CharBody.is_on_floor():
		CharBody.velocity.y = JUMP_FORCE
		#AnimCtrl._Air_anim()
		Mod_jump()
		
	
	
	if CharBody.velocity.y >= 0 and not CharBody.is_on_floor():
		Set_Move_State(Move_state.Falling)
	elif Input.is_action_just_released("Jump"):
		Set_Move_State(Move_state.Falling)
	
#endregion
	
	var direction = InputNode.getMoveInput()
	
	if can_move == false:
		return
	
	if direction:
		CharBody.velocity.x = direction * CurrentSpeed
		Set_Sub_State(Grounded_Substate.Running)
	else:
		CharBody.velocity.x = move_toward(CharBody.velocity.x, 0, SPEED)
		Set_Sub_State(Grounded_Substate.Idle)
	


func Sub_to_Grounded(function : Callable):
	Grounded.connect(function)

func Set_Move_State(NewState: Move_state) -> void:
	
	if NewState == Active_State:
		return
	Active_State = NewState
	match NewState:
		Move_state.Grounded:
			Grounded.emit()
			grav_mod = grav_mod_min
		Move_state.Ascending:
			Ascending.emit()
		Move_state.Falling:
			Falling.emit()
			CharBody.velocity.y = 0
			grav_mod = grav_mod_max
	#print("currentSate %s" %Active_State)

func Set_Sub_State(NewState: Grounded_Substate) -> void:
	
	if NewState == Active_SubState:
		return
	Active_SubState = NewState
	match NewState:
		Grounded_Substate.Idle:
			Idle.emit()
		Grounded_Substate.Running:
			Running.emit()
	
	
	print("GroundSate %s" % "Active_SubState")

func Override_state(State : Overrieds_States, set_active:bool) -> void:
	
	if set_active == true:
		Overrides |= State #Sets Bit Slot to 1 (Aka disables player controls)
		can_move = false
	else:
		
		Overrides &= ~State #Sets Bit Slot to 0
		if Overrides == Overrieds_States.none: # checks if should Enable player controls
			can_move = true
			print("can_move")
			pass
	print(Overrides)
	
	return
#region TestCode
	
	#match State:
		#Overrieds_States.Dash:
			#if set_active == true:
				#Overrides |= Overrieds_States.Dash 
			#else:
				#Overrides &= ~Overrieds_States.Dash
			#
		#Overrieds_States.stunned:
			#
			#
			#pass
		#
		#
		#pass
	
#endregion
	


func Mod_jump():
	Set_Move_State(Move_state.Ascending)
	await Falling
	Set_Move_State(Move_state.Falling)
	
	if CharBody.velocity.y < 0:
		CharBody.velocity.y /= 3
	
	
	print(" End of jump ")


func activateMove():
	CharBody.move_and_slide()

func calculateSpeed(addMods: Array[float], multMods: Array[float]):
	CurrentSpeed = SPEED
	
	for Mods in addMods:
		CurrentSpeed += Mods
	
	for Mods in multMods:
		CurrentSpeed *= Mods
	

func DropDown():
	if Input.is_action_pressed("Down") and CharBody.is_on_floor():
		CharBody.position.y += 1
