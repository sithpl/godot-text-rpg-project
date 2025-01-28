#SystemMenu.gd
extends Control

# ---------- Node References ----------

@onready var reset_button = get_node("VBoxContainer/ResetUIButton")
@onready var audio_button = get_node("VBoxContainer/AudioButton")
@onready var exit_button = get_node("VBoxContainer/ExitButton")

# ---------- Variables -----------

var hidden_controls = []

# ---------- Scene Load ----------

func _ready():
	# Connect the "pressed" signal of the "Reset UI" button to the reset_ui() function
	if reset_button and not reset_button.is_connected("pressed", Callable(self, "_on_reset_button_pressed")):
		reset_button.connect("pressed", Callable(self, "_on_reset_button_pressed"))
	# Connect signal to show SystemMenu
	connect("visibility_changed", Callable(self, "_on_visibility_changed"))

# Handle the reset button press
func _on_reset_button_pressed():
	reset_ui()

# Reset the UI
func reset_ui():
	# Call the reset_window() function from each window object
	var windows = [
		get_node("../Main"),
		get_node("../Communication"),
		get_node("../Stats"),
		get_node("../Equipment"),
		get_node("../World Map"),
		get_node("../Local Map")
		# Add more window nodes here if needed
	]
	for window in windows:
		if window.has_method("reset_window"):
			window.reset_window()

func _on_exit_button_pressed():
	print("Exit button pressed") # DEBUG
	# Load the Main scene 
	get_tree().change_scene_to_file("res://Scenes/Start.tscn")
