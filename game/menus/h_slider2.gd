extends HSlider

# Type the exact case-sensitive name of the audio bus you want to control
@export var bus_name: String = "Sound FX"

var bus_index: int

func _ready():
	# Fetch the system index of the targeted audio bus
	bus_index = AudioServer.get_bus_index(bus_name)
	
	# Synchronize the slider's starting position with the existing bus volume
	var current_volume_db = AudioServer.get_bus_volume_db(bus_index)
	value = db_to_linear(current_volume_db)


func _on_value_changed(new_value: float) -> void:
	# Convert the 0.0-1.0 slider range into a Decibel scale (dB) and apply it
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(new_value))
	
	# Optional: Mute the bus completely if the slider is dragged to the absolute bottom
	AudioServer.set_bus_mute(bus_index, new_value <= 0.001)
