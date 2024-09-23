extends Uppgrade

##preload
var DashFX : PackedScene = preload("res://Scenes/Dash_Effect.tscn")

@export_group("Nodes")
@export var VelComp : VELOCITY
@export var InputComp : INPUT
@export var Player : CharacterBody2D

@export_group("Settings")
@export var DashMod : int

var Has_Upgrade : bool = false

var Can_Dash : bool = true
var A_Flip : bool

func _physics_process(_delta: float) -> void:
	var DashFXtemp : Node = DashFX.instantiate()
	A_Flip = Player.BodySprite.flip_h
	
	if VelComp.Overrides == 1:
		if A_Flip:
			DashFXtemp.direction = -1
		else:
			DashFXtemp.direction = 1
		DashFXtemp.global_position = Player.global_position
		Player.get_parent().add_child(DashFXtemp)
	else:
		pass
	



func Dash(Dash_Force : int = 1500 ) -> void:
	var Dir = InputComp.getMoveInput()
	#var DashInput = InputComp.GetDashInput()
	
	
	if Can_Dash and Dir != 0 and Player.is_on_floor():
		
		print("Dir=", Dir)
		
		if Dir > 0:
			Dir = 1
		elif Dir < 0:
			Dir = -1
		
		print("hey!")
		Player.velocity.x = Dir * Dash_Force
		
		
		Can_Dash = false
		print("Dashed!")
		VelComp.Override_state(1,true) #one is implicitly converted to enum
		
		#Resets Bool after Cooldown (0.5) Sec
		#this timer is essentially Dash duration
		await get_tree().create_timer(0.2).timeout
		Player.velocity.x = 0
		VelComp.Override_state(1,false) 
		Can_Dash = true
	else:
		## PlaceHolder
		#Maybe add code to UI elements, Like a signal?
		print("Can't Dash")
		return
	
	




func _on_upgrades_component_upgrade_pickup() -> void:
	
	Has_Upgrade = true
	print("Upgrade Get: Dash")
	

func _on_velocity_comp_dash() -> void:
	
	
	
	
	pass # Replace with function body.
