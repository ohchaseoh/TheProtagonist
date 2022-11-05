extends KinematicBody2D

var speed = 200.0
var screen_size = Vector2.ZERO
var bullet = load("res://Bullet.tscn")
var can_fire = true

#don't know why it is like this
onready var target = position

func _ready():
	OS.window_fullscreen = true
	#gets the screen size?
	screen_size = get_viewport_rect().size
	#hide()
	

func _input(event):
	if event.is_action_pressed("shoot"):
		target = get_global_mouse_position()

func _process(delta):
	#basic movement commands
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		$PC_Sprite.animation = "run"
		
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		$PC_Sprite.animation = "run"
		$PC_Sprite.flip_v
		
	if Input.is_action_pressed("move_down"):
		direction.y += 1
		$PC_Sprite.animation = "run"
		
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
		$PC_Sprite.animation = "run"
		
	if direction.length() > 0:
		direction = direction.normalized()
		
	if direction.x == 0 && direction.y == 0:
		$PC_Sprite.animation = "idle"
	
	position += direction * speed * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	#gets the direction to the mouse click
	#position.direction_to(target)
	if Input.is_action_pressed("shoot") and can_fire:
		var b = bullet.instance()
		$CollisionShape2D.add_child(b)
		
		b.target = position.direction_to(target)
		
		b.rotation = position.angle_to_point(target)
		
		b.shoot = true
		can_fire = false
		yield(get_tree().create_timer(0.25), "timeout")
		can_fire = true
	
	
