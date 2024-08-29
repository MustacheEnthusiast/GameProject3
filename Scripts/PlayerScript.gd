extends CharacterBody2D

var Player_Stats = "res://Resources/Stats.gd"

@export_category("Player Stats")
@export var _Speed : int
@export var _Health : int
@export var _Attack_Damage : int
@export var _Jump_Force : int

@onready var _Sprite : AnimatedSprite2D = $PlayerSprite

var gravity : int = ProjectSettings.get_setting("physics/2d/default_gravity")
#Gravity is 980 by default


func _physics_process(delta: float) -> void:
	
		# handle left/right movement
	var direction = Input.get_axis("Move_left", "Move_right")
	if direction:
		if _Sprite.animation != &"run":
			#_Sprite.set_animation("Run")
			_Sprite.play("Run")
		else:
			pass
		velocity.x = direction * _Speed
		
	else:
		#_Sprite.set_animation("Idle Right")
		_Sprite.play("Idle Right")
		velocity.x = move_toward(velocity.x, 0, _Speed)
	
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += gravity * delta
	# flip the sprite. we do this before moving, so it flips
	# even if we stand at a wall
	if signf(velocity.x) != 0:
		_Sprite.flip_h = velocity.x < 0
	
	
	if Input.is_action_just_pressed("Jump"):
		_Sprite.play("Jump_Anim")
		print(_Sprite.animation_changed)
		
		if _Sprite.frame_progress == 5:
			velocity.y = _Jump_Force
		else:
			pass
		 
	else:
		#_Sprite.set_animation("Fall")
		velocity.y += gravity * delta + 15

	
	move_and_slide()
	
	
	
