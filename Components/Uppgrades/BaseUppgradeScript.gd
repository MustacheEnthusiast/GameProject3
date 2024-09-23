class_name Uppgrade extends Storage



signal UpgradePickup()

enum Upgrades{
	Ball,
	GrndPnd,
	Dash,
	Spit,
	DmgUp,
	DmgMax
}

func ApplyUpgrade(Upgrade : Upgrades) -> void:
	UpgradePickup.emit(Upgrade)
	match Upgrade:
		Upgrades.Dash:
			PowUps.Dash_Dodge = true
		Upgrades.Ball:
			PowUps.Ball_State = true
		Upgrades.Spit:
			PowUps.Acid_Spit = true
		Upgrades.GrndPnd:
			PowUps.Ground_Pound = true
		Upgrades.DmgUp:
			PowUps.DmgUp = true
		Upgrades.DmgMax:
			PowUps.DmgUp2 = true
	
	
	
	self.queue_free()
