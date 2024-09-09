class_name Attack_Comp extends Node

@export var Damage : float = 1 ##this value is kept low due to it representing hits
@export var Hit_Box : Array[Area2D]


func _process(_delta: float) -> void:
	#self.position = get_parent().position
	pass

func _Deal_DMG():
	##check if it's bodies or areas later
	Hit_Box[0].get_child(0).set_disabled(false)
	
	await get_tree().create_timer(0.3).timeout
	
	for body in Hit_Box[0].get_overlapping_bodies():
		
		if body.has_node("HealthComponent"):
			body.get_node("HealthComponent")._take_damage(Damage)
		
		print(body.name)
	
	
	Hit_Box[0].get_child(0).set_disabled(true)
	print("Attack")

#deprecated function

#func check_overlap(position: Vector2, width: float, height: float):
	#var rectangle_shape = RectangleShape2D.new()
	#rectangle_shape.extents = Vector2(width / 2, height / 2)	
	#var query = PhysicsShapeQueryParameters2D.new()
	#query.shape = rectangle_shape
	#query.transform = Transform2D(0, position)
	#query.collision_mask = 1	
	#var space_state = Node._physics_process
	#var result = space_state.intersect_shape(query)	
	#if result.size() > 0:
		#for item in result:
			#print("Overlapping with: ", item)
	#else:
		#print("No overlaps.")
