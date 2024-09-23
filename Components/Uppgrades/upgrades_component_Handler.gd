class_name Up_Handler extends Uppgrade

@onready var Checks = Storage

@export_category("Nodes")
@export var InputComp : INPUT

@export_group("Upgrades")
@export var DashUpgrade : Node

@export_category("Upgrade_Settings")
@export_group("Dash_Upgrade")
@export var Dash_Force : int
#var Action : Actions = Actions.None
enum Actions {None,Dash,Ball,Spit,DmgUp,DmgMax,GrndPnd}


func _ready():
	pass

func Call_Action(Action : Actions) -> void:
	
	#Callables Aka Functions but in var shape
	var DashFunc : Callable = DashUpgrade.Dash
	var BallFunc : Callable
	var SpitFunc : Callable
	var DmgUpFunc : Callable
	var DmgMaxFunc : Callable
	var GrndPndFunc : Callable
	
	##SwitchCase Action Checker
	#Checks Called upon action with an Enum key
	match Action:
		Actions.None: #Enum Key 0
			print("No action Called")
			return #Breaks us out of the function
		Actions.Dash: #Enum key 1
			if PowUps.Dash_Dodge == true:
				DashFunc.call()  #Calls Dash function in Dash_DashUpgrade
				print("Calling Dash")
		Actions.Ball:
			if PowUps.Ball_State == true:
				BallFunc.call()
				print("Calling BallState")
		Actions.Spit:
			if PowUps.Acid_Spit == true:
				SpitFunc.call()
				print("Calling Acid_Spit")
		Actions.DmgUp:
			if PowUps.DmgUp == true:
				DmgUpFunc.call()
				print("Calling Damage Upgrade")
		Actions.DmgMax:
			if PowUps.DmgUp2 == true:
				DmgMaxFunc.call()
				print("Calling Damage Max")
		Actions.GrndPnd:
			print("Pounded")
			if PowUps.Ground_Pound == true:
				GrndPndFunc.call()
				print("Calling Ground Pound")
	
	
	pass
#region Deprecated/NonFunctional code
## Code here might get revised or reused

#func _on_upgrade_get():
	#
	#
	#
	#pass


#func UpdateUpgrade(Upgrade : Upgrades, _UpgradePickup : Signal) -> void:
	#
	#match Upgrade:
		#Upgrades.Ball:
			#Ball_State = true
			#print("Upgrade Get: BallForm")
		#Upgrades.GrndPnd:
			#Ground_Pound = true
			#print("Upgrade Get: GroundPound")
		#Upgrades.Dash:
			#Dash_Dodge = true
			#print("Upgrade Get: Dash!")
		#Upgrades.Spit:
			#Acid_Spit = true
			#print("Upgrade Get: Spit")
		#Upgrades.DmgUp:
			#DmgUp = true
			#print("Upgrade Get: DmgUp")
		#Upgrades.DmgMax:
			#DmgUp2 = true
			#print("Upgrade Get: DmgMax")
		#
#endregion
