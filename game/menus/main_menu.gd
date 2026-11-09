extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	$"VBoxContainer/Test Level".grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_test_level_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/test level.tscn")


func _on_Quit_pressed() -> void:
	get_tree().quit()


func _on_enemyboss_test_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/test enemies.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/audio_settings.tscn")
