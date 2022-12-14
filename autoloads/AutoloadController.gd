extends Node

var menu_music = load("res://Assets/Sounds/Music/MenuMusic.mp3")
var level_music = load("res://Assets/Sounds/Music/LevelMusic.mp3")

var va_menu1 = load("res://Assets/Sounds/VA_Menu1.mp3")
var va_menu2 = load("res://Assets/Sounds/VA_Menu2.mp3")

func _ready():
	randomize()
	$MenuMusic.volume_db = -.6

func play_music():
	
	$MenuMusic.stream = menu_music
	$MenuMusic.play()

func play_va():
	
	if (randi() % 100) > 50:
		$IncredibleVA.stream = va_menu1
	else:
		$IncredibleVA.stream = va_menu2
	
	if not $IncredibleVA.is_playing():
		$IncredibleVA.play()
		
	var timer = get_tree().create_timer(7)
	yield(timer, "timeout")
	$IncredibleVA.stop()
	
func stop_va():
	
	$IncredibleVA.stop()
