class_name Storage extends Node

var Ball_State : bool 
var Ground_Pound : bool 
var Dash_Dodge : bool 
var Acid_Spit : bool 
var DmgUp : bool 
var DmgUp2 : bool 


func _ready() -> void:
	Ball_State = false
	Ground_Pound = false
	Dash_Dodge = false
	Acid_Spit = false
	DmgUp = false
	DmgUp2 = false
#func UpdateUpgrade(Upgrade) -> void:
	#
	#match Upgrade:
		#Upgrade.Ball_State:
			#Ball_State = true
		#Upgrade.Ground_Pound:
			#Ground_Pound = true
		#Upgrade.Dash_Dodge:
			#Dash_Dodge = true
		#Upgrade.Acid_Spit:
			#Acid_Spit = true
		#Upgrade.DmgUp:
			#DmgUp = true
		#Upgrade.DmgUp2:
			#DmgUp2 = true
		#
