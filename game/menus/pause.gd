extends CanvasLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	get_tree().paused = false
	$VBoxContainer/Restart.grab_focus()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/audio_settings.tscn")

func _on_button_2_pressed() -> void:
	get_tree().reload_current_scene()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
