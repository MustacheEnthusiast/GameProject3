
class_name Anim_Control extends Node
@export_category("Settings")
@export_group("Settings")
##Animated Sprite Node
@export var CharSprite : Sprite2D
@export var CharBody : CharacterBody2D
@export var AnimPlayer : AnimationPlayer
@export var VelComp : VELOCITY

var Dash_image : PackedScene = preload("res://Scenes/Dash_Effect.tscn")

var DashState = VELOCITY.Overrieds_States
var DashList : VELOCITY.Overrieds_States = DashState.none


var SubStates : VELOCITY.Grounded_Substate = VELOCITY.Grounded_Substate.Idle
#var Active_SubState : Grounded_Substate = Grounded_Substate.Idle

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass


func _on_velocity_comp_ascending() -> void:
	
	AnimPlayer.play("Jump")

func _on_velocity_comp_falling() -> void:
	
	AnimPlayer.play("Falling")

func _on_velocity_comp_grounded() -> void:
	
	AnimPlayer.play("Landing")
	await AnimPlayer.animation_finished
	
	match SubStates:
		VELOCITY.Grounded_Substate.Idle:
			AnimPlayer.play("Idle Right")
		VELOCITY.Grounded_Substate.Running:
			AnimPlayer.play("Run")


func _on_velocity_comp_idle() -> void:
	SubStates = VELOCITY.Grounded_Substate.Idle
	
	AnimPlayer.play("idleToRun",-1,-1, true )
	await AnimPlayer.animation_finished
	AnimPlayer.play("Idle Right")
	#print(AnimPlayer.animation_finished.emit)

func _on_velocity_comp_running() -> void:
	SubStates = VELOCITY.Grounded_Substate.Running
	
	AnimPlayer.play("idleToRun")
	await AnimPlayer.animation_finished
	AnimPlayer.play("Run")


func _on_health_component_took_damage() -> void:
	
	
	pass
