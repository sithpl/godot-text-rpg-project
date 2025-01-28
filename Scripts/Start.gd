#Start.gd
extends Node2D

# ---------- Scene References ----------

# ---------- Node References ----------
@onready var new_game_button : Button = $Control/VBoxContainer/NewGameButton
@onready var load_game_button : Button = $Control/VBoxContainer/LoadGameButton
@onready var exit_button : Button = $Control/VBoxContainer/ExitButton

# ---------- Scene Load ----------

func _ready():
	# Connect button signals to functions
	new_game_button.connect("pressed", Callable(self, "_on_new_game_pressed"))
	load_game_button.connect("pressed", Callable(self, "_on_load_game_pressed"))
	exit_button.connect("pressed", Callable(self, "_on_exit_pressed"))

# Function for starting a new game (for now just load Main.tscn)
# TO DO
func _on_new_game_button_pressed() -> void:
	print("New Game button pressed") # DEBUG
	# Load the Main scene 
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

# Function for loading an existing game (for now just load Main.tscn)
func _on_load_game_button_pressed() -> void:
	print("Load Game button pressed") # DEBUG

# Function to exit the game
func _on_exit_button_pressed() -> void:
	print("Exit button pressed") # DEBUG
	get_tree().quit()  # Close the game
