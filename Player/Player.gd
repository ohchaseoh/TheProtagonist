extends KinematicBody2D

var speed = 200.0
var screen_size = Vector2.ZERO
var bullet = load("res://Bullet.tscn")
var laser = load("res://laser.tscn")

var level = 1
export (int) var experience
export (int) var experience_total
export (int) var experience_required

var can_fire = true
var attacking = false
var dead = false

var alwaysOn = false
var canToggle = false
var laserOn = false

#don't know why it is like this
onready var target = position

func _ready():
	OS.window_fullscreen = true
	#gets the screen size?
	screen_size = get_viewport_rect().size
	
func _input(event):
	if event.is_action_pressed("shoot"):
		target = get_global_mouse_position()

func _process(delta):
	#basic movement commands
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	if Input.is_action_pressed("move_down"):
		direction.y += 1
		
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	$PC_Sprite.flip_h = direction.x < 0	
	
	if direction.length() > 0:
		direction = direction.normalized()
		
	if direction.x == 0 && direction.y == 0:
		$PC_Sprite.play("idle")
	elif attacking:
		$PC_Sprite.play("cast")
	else:
		$PC_Sprite.play("run")
	
	position += direction * speed * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if Input.is_action_just_pressed("laser"):
		if !laserOn:
			var l = laser.instance()
			$CollisionShape2D.add_child(l)
			
			l.player_position = self.get_global_position()
			#l.alwaysOn = alwaysOn
			#l.cast_to() = target * 100.0
			#l.rotation = position.angle_to_point(target) + 2.70
			l.is_casting = true
			
			
			
#			if alwaysOn == false && canToggle == false:
#				yield(get_tree().create_timer(0.25), "timeout")
#				l.queue_free()
#				l.is_casting = false
#			if canToggle == true:
#				yield(get_tree().create_timer(1), "timeout")
#				l.queue_free()
#				l.is_casting = false
			
			laserOn = true

			
		else:
			laserOn = false
			#print("test")
	
	
	
	
	#gets the direction to the mouse click
	#position.direction_to(target)
	if Input.is_action_pressed("shoot") and can_fire:
		var b = bullet.instance()
		$CollisionShape2D.add_child(b)
		
		attacking = true
		
		b.target = position.direction_to(target)
		b.rotation = position.angle_to_point(target)
		
		b.shoot = true
		can_fire = false
		yield(get_tree().create_timer(0.25), "timeout")
		can_fire = true

func _on_PC_Sprite_animation_finished():
	attacking = false



func _on_Area2D_body_entered(body):
	if(body.name == "Follow_BG"):
		emit_signal("player_death")
		self.queue_free()
	else:
		pass
