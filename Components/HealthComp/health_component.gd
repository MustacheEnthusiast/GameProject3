class_name HP_Component extends Node

@export var Health : float = 10
@export var Max_Health : float = 10
@export var Entity = get_parent()
@export var Hurt_Box : Area2D
var ded : bool = false
signal took_Damage
signal Healed

func _ready() -> void:
	
	##Initalises the health component and sets Hp to max
	Health = Max_Health
	

func _process(_delta: float) -> void:
	#Hurt_Box.position = Entity.position #debug option if hitbox is wonky
	
	
	if Health >= 0:
		_Death()
	#

## Take Damage functions that just reduces your current health with damage.
# I.e damage that goes in will be subtracted to the health value
func _take_damage(Damage : float):
	
	Health -= Damage
	
	took_Damage.emit()
	print("I ",Entity.name," took: ", Damage, " Damage.") #debugging 

## checks if you are dead and makes sure that you won't go over Max Hp
#
func _update_health():
	
	#checks if you are dead

	
	#limits health to max health value

	
	return Health


func _restore_health(Heal : float):
	
	Health += Heal
	
	if Health > Max_Health:
		Health = Max_Health
	else:
		Health = Health
	Healed.emit()



func _Death():
	
	if Health == 0 and ded == false:
		Entity.queue_free()
		print( "i'm dead", Entity.name)
		ded = true
	elif Health != 0 and ded == true:
		ded = false
	
	##Add Game over signal
