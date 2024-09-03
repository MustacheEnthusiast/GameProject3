class_name VELOCITY extends Node2D

@export var SPEED : float = 500
@export var JUMP_FORCE : float = -700
@export var FastGrav : float

@export_group("Nodes")
@export var CharBody : CharacterBody2D
@export var InputNode : INPUT

var CurrentSpeed : float = SPEED
var HoldingJump : bool = false

var Active_State: Move_state = Move_state.Grounded

enum Move_state{Grounded,Falling,Ascending}

signal Ascending
signal Falling
signal Grounded


var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var grav_mod_min : float = 1
@export var grav_mod_max : float = 2

var grav_mod : float = 1
func handleVelocity(delta):
	if not CharBody.is_on_floor():
		CharBody.velocity.y += gravity * delta * grav_mod
	else:
		
		Set_Move_State(Move_state.Grounded) 
		
	
	if Input.is_action_pressed("Down") and CharBody.is_on_floor():
		DropDown()
	
	if InputNode.getJumpInput() and CharBody.is_on_floor():
		CharBody.velocity.y = JUMP_FORCE
		
		Mod_jump()
		
	
	
	if CharBody.velocity.y >= 0 and not CharBody.is_on_floor():
		Set_Move_State(Move_state.Falling)
	elif Input.is_action_just_released("Jump"):
		Set_Move_State(Move_state.Falling)
	
	var direction = InputNode.getMoveInput()
	
	
	if direction:
		CharBody.velocity.x = direction * CurrentSpeed
		
	else:
		CharBody.velocity.x = move_toward(CharBody.velocity.x, 0, SPEED)
		
	

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
			grav_mod = grav_mod_max
	print("currentSate %s" %Active_State)

func Mod_jump():
	Set_Move_State(Move_state.Ascending) 
	await Falling
	Set_Move_State(Move_state.Falling) 
	
	if CharBody.velocity.y < 0:
		CharBody.velocity.y /= 2
	
	
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
