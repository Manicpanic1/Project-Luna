extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	$VBoxContainer/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$VBoxContainer/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$VBoxContainer/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_music_slider_mouse_exited() -> void:
	release_focus()


func _on_master_slider_mouse_exited() -> void:
	release_focus()


func _on_sfx_slider_mouse_exited() -> void:
	release_focus()


func _on_confirm_pressed() -> void:
	AudioServer.set_bus_volume_db(0,linear_to_db($VBoxContainer/MasterSlider.value))
	AudioServer.set_bus_volume_db(1,linear_to_db($VBoxContainer/MusicSlider.value))
	AudioServer.set_bus_volume_db(2,linear_to_db($VBoxContainer/SFXSlider.value))


func _on_back_pressed() -> void:
	get_tree().load_previous_scene
