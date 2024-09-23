extends Sprite2D


var direction

var player = preload("res://player.tscn")


func _ready() -> void:
	if direction > 0:
		flip_h = false
	else:
		flip_h = true

func _physics_process(_delta: float) -> void:
	
	var tween = create_tween()
	
	if direction > 0:
		flip_h = false
	else:
		flip_h = true
	position.x -= direction
	
	
	tween.tween_property(self, "modulate:a",0, 0.25)
	if modulate.a < 0.1:
		queue_free()
