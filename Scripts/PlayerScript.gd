class_name PLAYER extends CharacterBody2D

@export_group("Nodes")
@export var InputNode : INPUT
@export var VelocityNode : VELOCITY
@export var AnimSprite : AnimatedSprite2D
@export var HealthNode : Node


@export_group("Sprint/MoveMods")
@export var SprintMod : float = 1.5

var addMods : Array[float] = []
var multMods : Array[float] = []


func _physics_process(delta: float) -> void:
	
	AnimSprite.position = self.position
	
	if Engine.is_editor_hint():
		return
	
	addMods = []
	multMods = []
	
	InputNode.handleMoveInputs(delta)
	
	VelocityNode.calculateSpeed(addMods,multMods)
	VelocityNode.handleVelocity(delta)
	VelocityNode.activateMove()
	
	if signf(velocity.x) != 0:
		AnimSprite.flip_h = velocity.x < 0
	
	


#region Old_Original_Code


#var Player_Stats = "res://Resources/Stats.gd"
#
#@export_category("Player Stats")
#@export var _Speed : int
#@export var _Health : int
#@export var _Attack_Damage : int
#@export var _Jump_Force : int
#
#@onready var _Sprite : AnimatedSprite2D = $AnimSprite
#
#var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")
##Gravity is 980 by default


#func _physics_process(delta: float) -> void:
	#
	#_movement()
	#_gravity(delta)
	#
	###Jump
	#if Input.is_action_just_pressed("Jump"):
		#velocity.y += _Jump_Force
	#
	#
	#move_and_slide()


#func _gravity(delta: float) -> void:
	#
	#if is_on_floor():
		#velocity.y = 0
	#else:
		#velocity.y += gravity * delta
	#
	#if signf(velocity.x) != 0:
		#_Sprite.flip_h = velocity.x < 0
	

#func _movement() -> void:
	###Jump
	#if Input.is_action_just_pressed("Jump"):
		#velocity.y += _Jump_Force
	#
	#var direction = Input.get_axis("Move_left", "Move_right")
	#if direction:
		#velocity.x = direction * _Speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, _Speed)
#endregion
