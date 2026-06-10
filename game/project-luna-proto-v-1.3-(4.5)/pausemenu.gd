extends Control

func _process(delta):	testesc()
	
func _ready():
	$AnimationPlayer.play("RESET")

func Resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("Blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("Blur")

func testesc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		Resume()


func _on_button_pressed() -> void:
	Resume()


func _on_button_2_pressed() -> void:
	Resume()
	get_tree().reload_current_scene()


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")


func _on_button_4_pressed() -> void:
	get_tree().quit()
