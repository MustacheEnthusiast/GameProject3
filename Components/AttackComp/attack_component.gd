class_name Attack_Comp extends Node

@export var Damage : float = 1 ##this value is kept low due to it representing hits
@export var Hit_Box : Array[Area2D]
var Flipped : bool = false

func _process(_delta: float) -> void:
	#self.position = get_parent().position
	pass

func _Deal_DMG():
	##check if it's bodies or areas later
	
	#Simplified names for the Hitbox Refs
	var Left_Hitbox = Hit_Box[1].get_child(0)
	var Left_Hitbox_Image = Hit_Box[1].get_child(1)
	var Right_Hitbox = Hit_Box[0].get_child(0)
	var Right_Hitbox_Image = Hit_Box[0].get_child(1)
	
	##Checks if you are flipped or not and activates
	#the corresponding hitbox depending on direction
	if Flipped == false:
		Right_Hitbox.set_disabled(false)
		Right_Hitbox_Image.set_visible(true)
		await get_tree().create_timer(0.3).timeout
		for body in Hit_Box[0].get_overlapping_bodies():
			
			if body.is_in_group("Enemies") and body.has_node("HealthComponent"):
				Hitstun(0.2,0.4)
				body.get_node("HealthComponent")._take_damage(Damage)
			
			print("Attack Right")
		Right_Hitbox.set_disabled(true)
		Right_Hitbox_Image.set_visible(false)
	
	elif Flipped == true:
		Left_Hitbox.set_disabled(false)
		Left_Hitbox_Image.set_visible(true)
		await get_tree().create_timer(0.3).timeout
		for body in Hit_Box[1].get_overlapping_bodies():
			
			if body.has_node("HealthComponent") and body.is_in_group("Enemies"):
				Hitstun(0.2,0.4)
				body.get_node("HealthComponent")._take_damage(Damage)
			
			print("Attack Left")
		Left_Hitbox.set_disabled(true)
		Left_Hitbox_Image.set_visible(false)


func _on_player_flipped():
	Flipped = true

func _on_player_not_flipped():
	Flipped = false

func Hitstun(timeScale, duration):
	Engine.time_scale = timeScale
	await get_tree().create_timer(duration * timeScale).timeout
	Engine.time_scale = 1.0

func checkDir() -> void:
	pass
