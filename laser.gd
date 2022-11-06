extends RayCast2D
#laser file

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player_position = position
onready var isOn = false
var alwaysOn = false
var is_casting := false setget set_is_casting
var off_cooldown = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO
	


#func _unhandled_input(event: InputEvent) -> void:
#	if event is InputEventMouseButton:
#		self.is_casting = event.pressed
#	



func _physics_process(delta: float) -> void:
	
	
	if Input.is_action_just_pressed("laser"):
	
		queue_free()
			
	
	
	cast_to = self.get_local_mouse_position() * 50
	var cast_point := cast_to
	force_raycast_update()
	print("test2")
	if is_colliding():
		print("test1")
		cast_point = to_local(get_collision_point())
		if(get_collider().is_in_group("Walls")):
			pass
		elif(off_cooldown):
			get_collider().hit(1)
			off_cooldown = false
			yield(get_tree().create_timer(0.1), "timeout")
			off_cooldown = true
		
	$Line2D.points[1] = cast_point
	
func set_is_casting(cast: bool)-> void:
	is_casting = cast
	
	if is_casting:
		appear()
	else:
		disappear()
	
	set_physics_process(is_casting)
	
func appear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 0, 10.0, 0.2)
	$Tween.start()
	
	
func disappear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 10.0, 0, 0.1)
	$Tween.start()
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
