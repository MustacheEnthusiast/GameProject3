class_name VELOCITY extends Node2D

@export var SPEED : float = 500
@export var JUMP_FORCE : float = -700

@export_group("Nodes")
@export var CharBody : CharacterBody2D
@export var InputNode : INPUT

var CurrentSpeed : float = SPEED

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func handleVelocity(delta):
	if not CharBody.is_on_floor():
		CharBody.velocity.y += gravity * delta
		
	
	if InputNode.getJumpInput() and CharBody.is_on_floor():
		CharBody.velocity.y = JUMP_FORCE
	
	var direction = InputNode.getMoveInput()
	if direction:
		CharBody.velocity.x = direction * CurrentSpeed
	else:
		CharBody.velocity.x = move_toward(CharBody.velocity.x, 0, SPEED)
		
	
	
	


func activateMove():
	CharBody.move_and_slide()

func calculateSpeed(addMods: Array[float], multMods: Array[float]):
	CurrentSpeed = SPEED
	
	for Mods in addMods:
		CurrentSpeed += Mods
	
	for Mods in multMods:
		CurrentSpeed *= Mods
	
